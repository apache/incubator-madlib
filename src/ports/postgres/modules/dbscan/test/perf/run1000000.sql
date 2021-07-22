\timing on
DROP TABLE IF EXISTS output_blobs_64d_10c_003s_1000000p,output_blobs_64d_10c_003s_1000000p_summary;
SELECT madlib.dbscan('input_blobs_64d_10c_003s_1000000p', 'output_blobs_64d_10c_003s_1000000p', 'id', 'point', 0.0002, 2, 'squared_dist_norm2', 'kd_tree');
COPY output_blobs_64d_10c_003s_1000000p TO '/home/gpadmin/madlib/src/ports/postgres/modules/dbscan/test/perf/blobs/output_blobs_64d_10c_003s_1000000p.csv' CSV HEADER;
