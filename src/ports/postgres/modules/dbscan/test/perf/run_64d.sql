\set MADLIB_PERF_DIR '/home/':USER'/madlib/src/ports/postgres/modules/dbscan/test/perf/blobs/'
DROP TABLE IF EXISTS output_blobs_04d_4c_150s_10000p,output_blobs_04d_4c_150s_10000p_summary;
DROP TABLE IF EXISTS output_blobs_64d_10c_003s_10000p,output_blobs_64d_10c_003s_10000p_summary;
SELECT madlib.dbscan('input_blobs_64d_10c_003s_10000p', 'output_blobs_64d_10c_003s_10000p', 'id', 'point', 0.0009, 3, 'squared_dist_norm2', 'kd_tree');
COPY output_blobs_64d_10c_003s_10000p TO :'MADLIB_PERF_DIR''output_blobs_64d_10c_003s_10000p.csv' CSV HEADER;
