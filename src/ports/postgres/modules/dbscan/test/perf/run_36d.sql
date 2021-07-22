\set MADLIB_PERF_DIR '/home/':USER'/madlib/src/ports/postgres/modules/dbscan/test/perf/blobs/'
DROP TABLE IF EXISTS output_blobs_36d_8c_005s_10000p,output_blobs_36d_8c_005s_10000p_summary;
SELECT madlib.dbscan('input_blobs_36d_8c_005s_10000p', 'output_blobs_36d_8c_005s_10000p', 'id', 'point', 0.0014, 3, 'squared_dist_norm2', 'kd_tree');
COPY output_blobs_36d_8c_005s_10000p TO :'MADLIB_PERF_DIR''output_blobs_36d_8c_005s_10000p.csv' CSV HEADER;
