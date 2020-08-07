\timing on
DROP TABLE IF EXISTS output_blobs_03d_3c_200s_50000p, output_blobs_03d_3c_200s_50000p_summary;
SELECT madlib.dbscan('input_blobs_03d_3c_200s_50000p', 'output_blobs_03d_3c_200s_50000p', 'id', 'point', 0.2000, 1, 'dist_norm2', 'kd_tree');
COPY output_blobs_03d_3c_200s_50000p TO '/home/gpadmin/madlib/src/ports/postgres/modules/dbscan/test/perf/blobs/output_blobs_03d_3c_200s_50000p.csv' CSV HEADER;
