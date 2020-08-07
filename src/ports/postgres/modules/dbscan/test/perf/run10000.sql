\timing on
\set MADLIB_PERF_DIR '/home/':USER'/madlib/src/ports/postgres/modules/dbscan/test/perf/blobs/'

DROP TABLE IF EXISTS prev_node, prev_node0, prev_node1, prev_node2, prev_node3, prev_node4, prev_node5, prev_node6, prev_node7, prev_node8, prev_node9, prev_node10, prev_node11, prev_node12, prev_node13, prev_node14, prev_node15, prev_node16, prev_node17, prev_node18;
DROP TABLE IF EXISTS output_blobs_03d_3c_200s_10000p,output_blobs_03d_3c_200s_10000p_summary;
SELECT madlib.dbscan('input_blobs_03d_3c_200s_10000p', 'output_blobs_03d_3c_200s_10000p', 'id', 'point', 0.0256, 1, 'squared_dist_norm2', 'kd_tree');
COPY output_blobs_03d_3c_200s_10000p TO :'MADLIB_PERF_DIR''output_blobs_03d_3c_200s_10000p.csv' CSV HEADER;
DROP TABLE IF EXISTS prev_node, prev_node0, prev_node1, prev_node2, prev_node3, prev_node4, prev_node5, prev_node6, prev_node7, prev_node8, prev_node9, prev_node10, prev_node11, prev_node12, prev_node13, prev_node14, prev_node15, prev_node16, prev_node17, prev_node18;
DROP TABLE IF EXISTS output_blobs_04d_4c_150s_10000p,output_blobs_04d_4c_150s_10000p_summary;
SELECT madlib.dbscan('input_blobs_04d_4c_150s_10000p', 'output_blobs_04d_4c_150s_10000p', 'id', 'point', 0.0400, 1, 'squared_dist_norm2', 'kd_tree');
COPY output_blobs_04d_4c_150s_10000p TO :'MADLIB_PERF_DIR''output_blobs_04d_4c_150s_10000p.csv' CSV HEADER;
DROP TABLE IF EXISTS prev_node, prev_node0, prev_node1, prev_node2, prev_node3, prev_node4, prev_node5, prev_node6, prev_node7, prev_node8, prev_node9, prev_node10, prev_node11, prev_node12, prev_node13, prev_node14, prev_node15, prev_node16, prev_node17, prev_node18;
DROP TABLE IF EXISTS output_blobs_09d_5c_100s_10000p,output_blobs_09d_5c_100s_10000p_summary;
SELECT madlib.dbscan('input_blobs_09d_5c_100s_10000p', 'output_blobs_09d_5c_100s_10000p', 'id', 'point', 0.0600, 1, 'squared_dist_norm2', 'kd_tree');
COPY output_blobs_09d_5c_100s_10000p TO :'MADLIB_PERF_DIR''output_blobs_09d_5c_100s_10000p.csv' CSV HEADER;
DROP TABLE IF EXISTS prev_node, prev_node0, prev_node1, prev_node2, prev_node3, prev_node4, prev_node5, prev_node6, prev_node7, prev_node8, prev_node9, prev_node10, prev_node11, prev_node12, prev_node13, prev_node14, prev_node15, prev_node16, prev_node17, prev_node18;
DROP TABLE IF EXISTS output_blobs_16d_6c_007s_10000p,output_blobs_16d_6c_007s_10000p_summary;
SELECT madlib.dbscan('input_blobs_16d_6c_007s_10000p', 'output_blobs_16d_6c_007s_10000p', 'id', 'point', 0.0018, 1, 'squared_dist_norm2', 'kd_tree');
COPY output_blobs_16d_6c_007s_10000p TO :'MADLIB_PERF_DIR''output_blobs_16d_6c_007s_10000p.csv' CSV HEADER;
DROP TABLE IF EXISTS prev_node, prev_node0, prev_node1, prev_node2, prev_node3, prev_node4, prev_node5, prev_node6, prev_node7, prev_node8, prev_node9, prev_node10, prev_node11, prev_node12, prev_node13, prev_node14, prev_node15, prev_node16, prev_node17, prev_node18;
DROP TABLE IF EXISTS output_blobs_25d_7c_006s_10000p,output_blobs_25d_7c_006s_10000p_summary;
SELECT madlib.dbscan('input_blobs_25d_7c_006s_10000p', 'output_blobs_25d_7c_006s_10000p', 'id', 'point', 0.0016, 1, 'squared_dist_norm2', 'kd_tree');
COPY output_blobs_25d_7c_006s_10000p TO :'MADLIB_PERF_DIR''output_blobs_25d_7c_006s_10000p.csv' CSV HEADER;
DROP TABLE IF EXISTS prev_node, prev_node0, prev_node1, prev_node2, prev_node3, prev_node4, prev_node5, prev_node6, prev_node7, prev_node8, prev_node9, prev_node10, prev_node11, prev_node12, prev_node13, prev_node14, prev_node15, prev_node16, prev_node17, prev_node18;
DROP TABLE IF EXISTS output_blobs_36d_8c_005s_10000p,output_blobs_36d_8c_005s_10000p_summary;
SELECT madlib.dbscan('input_blobs_36d_8c_005s_10000p', 'output_blobs_36d_8c_005s_10000p', 'id', 'point', 0.0014, 1, 'squared_dist_norm2', 'kd_tree');
COPY output_blobs_36d_8c_005s_10000p TO :'MADLIB_PERF_DIR''output_blobs_36d_8c_005s_10000p.csv' CSV HEADER;
DROP TABLE IF EXISTS prev_node, prev_node0, prev_node1, prev_node2, prev_node3, prev_node4, prev_node5, prev_node6, prev_node7, prev_node8, prev_node9, prev_node10, prev_node11, prev_node12, prev_node13, prev_node14, prev_node15, prev_node16, prev_node17, prev_node18;
DROP TABLE IF EXISTS output_blobs_04d_4c_150s_10000p,output_blobs_04d_4c_150s_10000p_summary;
DROP TABLE IF EXISTS output_blobs_49d_9c_004s_10000p,output_blobs_49d_9c_004s_10000p_summary;
SELECT madlib.dbscan('input_blobs_49d_9c_004s_10000p', 'output_blobs_49d_9c_004s_10000p', 'id', 'point', 0.0012, 1, 'squared_dist_norm2', 'kd_tree');
COPY output_blobs_49d_9c_004s_10000p TO :'MADLIB_PERF_DIR''output_blobs_49d_9c_004s_10000p.csv' CSV HEADER;
DROP TABLE IF EXISTS prev_node, prev_node0, prev_node1, prev_node2, prev_node3, prev_node4, prev_node5, prev_node6, prev_node7, prev_node8, prev_node9, prev_node10, prev_node11, prev_node12, prev_node13, prev_node14, prev_node15, prev_node16, prev_node17, prev_node18;
DROP TABLE IF EXISTS output_blobs_04d_4c_150s_10000p,output_blobs_04d_4c_150s_10000p_summary;
DROP TABLE IF EXISTS output_blobs_64d_10c_003s_10000p,output_blobs_64d_10c_003s_10000p_summary;
SELECT madlib.dbscan('input_blobs_64d_10c_003s_10000p', 'output_blobs_64d_10c_003s_10000p', 'id', 'point', 0.0009, 1, 'squared_dist_norm2', 'kd_tree');
COPY output_blobs_64d_10c_003s_10000p TO :'MADLIB_PERF_DIR''output_blobs_64d_10c_003s_10000p.csv' CSV HEADER;
