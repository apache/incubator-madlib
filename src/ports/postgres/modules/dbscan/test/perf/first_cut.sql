DROP TABLE IF EXISTS prev_node;
CREATE TABLE prev_node AS
WITH world_bounds AS (
    SELECT
        i,
        min(point[i]) AS lower,
        max(point[i]) AS upper,
        max(point[i]) - min(point[i]) AS size,
        ceil((max(point[i]) - min(point[i])) / 0.2)::INT AS eps_bins
    FROM generate_series(1,25) AS i, source_table 
    GROUP BY i
),
density_map AS (
    SELECT i, eps_bin,
        eps_bins,
        COALESCE(density, 0) AS density
    FROM (
        SELECT i, eps_bins,
            generate_series(0, eps_bins - 1) AS eps_bin
        FROM world_bounds
    ) g LEFT JOIN (
        SELECT i,
            floor((point[i] - lower)/0.2)::INT AS eps_bin,
            eps_bins,
            COUNT(*) AS density
        FROM
            world_bounds,
            source_table
        GROUP BY i, eps_bin, eps_bins
    ) a
    USING (i, eps_bin, eps_bins)
),
loss_table AS (
    SELECT i, eps_bin,
        left_internal,
        10000 - left_internal AS right_internal,
        left_external,
        right_external,
        madlib._dbscan_segmentation_loss(
            left_internal,
            10000 - left_internal,
            left_external,
            right_external,
            3::BIGINT,
            V,
            0.2::DOUBLE PRECISION,
            25::BIGINT,
            eps_bin::DOUBLE PRECISION,
            eps_bins::DOUBLE PRECISION
        ) AS losses
    FROM (
        SELECT i, eps_bin, eps_bins,
            3::BIGINT AS num_segs,
            COALESCE(density, 0) AS right_external,
            COALESCE(LEAD(density) OVER(PARTITION BY i ORDER BY eps_bin), 0) AS left_external,
            SUM(density) OVER(PARTITION BY i ORDER BY eps_bin)::BIGINT AS left_internal
        FROM (
            SELECT i, generate_series(0, eps_bins - 1) AS eps_bin FROM world_bounds
        ) g LEFT JOIN density_map USING(i, eps_bin)
    ) params,
    (
        SELECT
            madlib._dbscan_safe_exp(sum(
                madlib._dbscan_safe_ln(size)
            )) AS V
        FROM world_bounds
    ) AS volume
    -- We don't want to split after the last bin (eps_bin = eps_bins - 1), but we need
    --  it in order to compute right_external with the LEAD() agg for the bin
    --  just to the left of it (eps_bin = eps_bins - 2). Therefore, it's included in the
    --  params query but filtered out at the end with a WHERE clause.  We would
    --  have the same issue for eps_bin = 0 except that we always make
    --  the cut after the bin rather than before (between eps_bin and eps_bin + 1)
    WHERE eps_bin != eps_bins - 1
),
optimize AS (
    SELECT i, lower, cutoff, upper,
           left_avail, right_avail,
           left_internal, right_internal
    FROM (
        SELECT
            i,
            left_internal,
            right_internal,
            (losses).left_avail AS left_avail,
            (losses).right_avail AS right_avail,
            GREATEST((losses).left_loss,(losses).right_loss) AS total_loss,
            min(
                GREATEST((losses).left_loss,(losses).right_loss)
            ) OVER() AS total_min,
            wb.lower,
            wb.lower + 0.2*(eps_bin+1) AS cutoff,
            wb.upper
        FROM loss_table JOIN world_bounds wb USING(i)
    ) a WHERE total_loss = total_min LIMIT 1
)
SELECT s.id,
    ARRAY[i] AS coords,
    CASE WHEN s.point[i] < cutoff
        THEN left_avail
        ELSE right_avail
    END AS avail_segs,
    CASE WHEN point[i] < cutoff
        THEN left_internal
        ELSE right_internal
    END AS points_in_node,
    CASE WHEN s.point[i] < cutoff
        THEN ARRAY[lower]
        ELSE ARRAY[cutoff]
    END AS lower_bounds,
    CASE WHEN s.point[i] < cutoff
        THEN ARRAY[cutoff]
        ELSE ARRAY[upper]
    END AS upper_bounds,
    (s.point[i] > cutoff)::INT::BIT(16) AS node_id
FROM optimize, source_table s;
