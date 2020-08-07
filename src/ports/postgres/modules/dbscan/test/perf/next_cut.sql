DROP TABLE IF EXISTS next_cut;
CREATE TABLE next_cut AS
            WITH node_bounds AS (
                SELECT
                    i,
                    node_id,
                    avail_segs,
                    points_in_node,
                    min(point[i]) AS lower,
                    max(point[i]) AS upper,
                    max(point[i]) - min(point[i]) AS size,
                    ceil((max(point[i]) - min(point[i])) / 0.2)::INT AS eps_bins
                FROM generate_series(1, 25) AS i,
                    prev_node JOIN source_table USING (id)
                GROUP BY 1,2,3,4
            ), density_map AS (
                SELECT i, node_id, eps_bin,
                    COALESCE( density, 0) AS density
                FROM (
                    SELECT node_id, i,
                        generate_series(0, eps_bins - 1) AS eps_bin
                    FROM node_bounds
                ) g LEFT JOIN (
                    SELECT node_id, i,
                        floor((point[i] - lower)/0.2)::INT AS eps_bin,
                        COUNT(*) AS density
                    FROM
                        node_bounds JOIN prev_node USING (node_id)
                        JOIN source_table USING (id)
                    GROUP BY node_id, i, eps_bin
                ) a
                USING(i, node_id, eps_bin)
            ), params AS (
                SELECT i, node_id, eps_bin, eps_bins,
                    COALESCE(density, 0) AS right_external,
                    COALESCE(LEAD(density) OVER(PARTITION BY node_id,i ORDER BY eps_bin), 0) AS left_external,
                    SUM(density) OVER(PARTITION BY node_id,i ORDER BY eps_bin)::BIGINT AS left_internal
                FROM (
                    SELECT i, node_id, eps_bins, generate_series(0, eps_bins - 1) AS eps_bin FROM node_bounds
                ) g LEFT JOIN density_map USING(i, node_id, eps_bin)
            ), volume AS (
                SELECT
                    node_id,
                    avail_segs,
                    points_in_node,
                    madlib._dbscan_safe_exp(sum(
                        madlib._dbscan_safe_ln(size)
                    )) AS V
                FROM node_bounds
                WHERE i=1
                GROUP BY 1,2,3
            ), loss_table AS (
SELECT i, node_id, eps_bin,
                    left_internal,
                    points_in_node - left_internal AS right_internal,
                    left_external,
                    right_external,
                    madlib._dbscan_segmentation_loss(
                        left_internal,
                        points_in_node - left_internal,
                        left_external,
                        right_external,
                        avail_segs,
                        V,
                        0.2::DOUBLE PRECISION,
                        25::BIGINT,
                        eps_bin::DOUBLE PRECISION,
                        eps_bins::DOUBLE PRECISION
                    ) AS losses
                FROM params JOIN volume USING (node_id)
                -- We don't want to split after the last bin (eps_bin = eps_bins - 1), but we need
                --  it in order to compute right_external with the LEAD() agg for the bin
                --  just to the left of it (eps_bin = eps_bins - 2). Therefore, it's included in the
                --  params query but filtered out at the end with a WHERE clause.  We would
                --  have the same issue for eps_bin = 0 except that we always make
                --  the cut after the bin rather than before (between eps_bin and eps_bin + 1)
                WHERE eps_bin != eps_bins - 1
            ), optimize AS (
                SELECT * FROM (
                    SELECT
                        node_id,
                        i,
                        left_internal,
                        right_internal,
                        (losses).left_avail,
                        (losses).right_avail,
                        node_bounds.lower,
                        CASE WHEN (losses).left_avail = 0
                            THEN
                                node_bounds.lower
                            ELSE
                                node_bounds.lower + 0.2*(eps_bin+1)
                        END AS cutoff,
                        node_bounds.upper,
                        ROW_NUMBER() OVER(
                            PARTITION BY node_id
                            ORDER BY GREATEST((losses).left_loss,(losses).right_loss)
                        ) AS loss_rank
                    FROM loss_table JOIN node_bounds USING(i, node_id)
                ) a WHERE loss_rank = 1
            )
 SELECT id, coords || i AS coords,
                CASE WHEN point[i] < opt.cutoff
                    THEN left_avail
                    ELSE right_avail
                END AS avail_segs,
                CASE WHEN point[i] < opt.cutoff
                    THEN left_internal
                    ELSE right_internal
                END AS points_in_node,
                lower_bounds ||
                    CASE WHEN point[i] < opt.cutoff
                    THEN
                        lower
                    ELSE
                        opt.cutoff
                    END AS lower_bounds,
                    opt.cutoff,
                upper_bounds ||
                    CASE WHEN point[i] < opt.cutoff
                    THEN
                        opt.cutoff
                    ELSE
                        upper
                    END AS upper_bounds,
                (node_id << 1) | (point[i] >= opt.cutoff)::INT::BIT(16) AS node_id
            FROM source_table
            JOIN prev_node
                USING (id)
            JOIN optimize opt
                USING (node_id);
