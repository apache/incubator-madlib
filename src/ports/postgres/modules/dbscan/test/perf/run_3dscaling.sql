\timing on
-- First scaling run used 0.0280 for all, with squared_dist_norm2:
--DROP TABLE IF EXISTS output_blobs_03d_3c_200s_50000p, output_blobs_03d_3c_200s_50000p_summary;
--SELECT madlib.dbscan('input_blobs_03d_3c_200s_50000p', 'output_blobs_03d_3c_200s_50000p', 'id', 'point', 0.0280, 1, 'squared_dist_norm2', 'kd_tree');
--COPY output_blobs_03d_3c_200s_50000p TO '/home/gpadmin/madlib/src/ports/postgres/modules/dbscan/test/perf/blobs/output_blobs_03d_3c_200s_50000p.csv' CSV HEADER;

DROP TABLE IF EXISTS prev_node, prev_node0, prev_node1, prev_node2, prev_node3, prev_node4, prev_node5, prev_node6, prev_node7, prev_node8, prev_node9, prev_node10, prev_node11, prev_node12, prev_node13, prev_node14, prev_node15, prev_node16, prev_node17, prev_node18;
DROP TABLE IF EXISTS output_blobs_03d_3c_200s_25000p, output_blobs_03d_3c_200s_25000p_summary;
SELECT madlib.dbscan('input_blobs_03d_3c_200s_25000p', 'output_blobs_03d_3c_200s_25000p', 'id', 'point', 0.2000, 3, 'dist_norm2', 'kd_tree');
COPY output_blobs_03d_3c_200s_25000p TO '/home/gpadmin/madlib/src/ports/postgres/modules/dbscan/test/perf/blobs/output_blobs_03d_3c_200s_25000p.csv' CSV HEADER;

DROP TABLE IF EXISTS prev_node, prev_node0, prev_node1, prev_node2, prev_node3, prev_node4, prev_node5, prev_node6, prev_node7, prev_node8, prev_node9, prev_node10, prev_node11, prev_node12, prev_node13, prev_node14, prev_node15, prev_node16, prev_node17, prev_node18;
DROP TABLE IF EXISTS output_blobs_03d_3c_200s_50000p, output_blobs_03d_3c_200s_50000p_summary;
SELECT madlib.dbscan('input_blobs_03d_3c_200s_50000p', 'output_blobs_03d_3c_200s_50000p', 'id', 'point', 0.1600, 3, 'dist_norm2', 'kd_tree');
COPY output_blobs_03d_3c_200s_50000p TO '/home/gpadmin/madlib/src/ports/postgres/modules/dbscan/test/perf/blobs/output_blobs_03d_3c_200s_50000p.csv' CSV HEADER;

DROP TABLE IF EXISTS prev_node, prev_node0, prev_node1, prev_node2, prev_node3, prev_node4, prev_node5, prev_node6, prev_node7, prev_node8, prev_node9, prev_node10, prev_node11, prev_node12, prev_node13, prev_node14, prev_node15, prev_node16, prev_node17, prev_node18;
DROP TABLE IF EXISTS output_blobs_03d_3c_200s_100000p,output_blobs_03d_3c_200s_100000p_summary;
SELECT madlib.dbscan('input_blobs_03d_3c_200s_100000p', 'output_blobs_03d_3c_200s_100000p', 'id', 'point', 0.1500, 3, 'dist_norm2', 'kd_tree');
COPY output_blobs_03d_3c_200s_100000p TO '/home/gpadmin/madlib/src/ports/postgres/modules/dbscan/test/perf/blobs/output_blobs_03d_3c_200s_100000p.csv' CSV HEADER;

DROP TABLE IF EXISTS prev_node, prev_node0, prev_node1, prev_node2, prev_node3, prev_node4, prev_node5, prev_node6, prev_node7, prev_node8, prev_node9, prev_node10, prev_node11, prev_node12, prev_node13, prev_node14, prev_node15, prev_node16, prev_node17, prev_node18;
DROP TABLE IF EXISTS output_blobs_03d_3c_200s_200000p,output_blobs_03d_3c_200s_200000p_summary;
SELECT madlib.dbscan('input_blobs_03d_3c_200s_200000p', 'output_blobs_03d_3c_200s_200000p', 'id', 'point', 0.1260, 3, 'dist_norm2', 'kd_tree');
COPY output_blobs_03d_3c_200s_200000p TO '/home/gpadmin/madlib/src/ports/postgres/modules/dbscan/test/perf/blobs/output_blobs_03d_3c_200s_20000p.csv' CSV HEADER;

DROP TABLE IF EXISTS prev_node, prev_node0, prev_node1, prev_node2, prev_node3, prev_node4, prev_node5, prev_node6, prev_node7, prev_node8, prev_node9, prev_node10, prev_node11, prev_node12, prev_node13, prev_node14, prev_node15, prev_node16, prev_node17, prev_node18;
DROP TABLE IF EXISTS output_blobs_03d_3c_200s_400000p,output_blobs_03d_3c_200s_400000p_summary;
SELECT madlib.dbscan('input_blobs_03d_3c_200s_400000p', 'output_blobs_03d_3c_200s_400000p', 'id', 'point', 0.1000, 3, 'dist_norm2', 'kd_tree');
COPY output_blobs_03d_3c_200s_400000p TO '/home/gpadmin/madlib/src/ports/postgres/modules/dbscan/test/perf/blobs/output_blobs_03d_3c_200s_400000p.csv' CSV HEADER;

DROP TABLE IF EXISTS prev_node, prev_node0, prev_node1, prev_node2, prev_node3, prev_node4, prev_node5, prev_node6, prev_node7, prev_node8, prev_node9, prev_node10, prev_node11, prev_node12, prev_node13, prev_node14, prev_node15, prev_node16, prev_node17, prev_node18;
DROP TABLE IF EXISTS output_blobs_03d_3c_200s_800000p,output_blobs_03d_3c_200s_800000p_summary;
SELECT madlib.dbscan('input_blobs_03d_3c_200s_800000p', 'output_blobs_03d_3c_200s_800000p', 'id', 'point', 0.0800, 3, 'dist_norm2', 'kd_tree');
COPY output_blobs_03d_3c_200s_800000p TO '/home/gpadmin/madlib/src/ports/postgres/modules/dbscan/test/perf/blobs/output_blobs_03d_3c_200s_800000p.csv' CSV HEADER;

DROP TABLE IF EXISTS prev_node, prev_node0, prev_node1, prev_node2, prev_node3, prev_node4, prev_node5, prev_node6, prev_node7, prev_node8, prev_node9, prev_node10, prev_node11, prev_node12, prev_node13, prev_node14, prev_node15, prev_node16, prev_node17, prev_node18;
DROP TABLE IF EXISTS output_blobs_03d_3c_200s_1600000p,output_blobs_03d_3c_200s_1600000p_summary;
SELECT madlib.dbscan('input_blobs_03d_3c_200s_1600000p', 'output_blobs_03d_3c_200s_1600000p', 'id', 'point', 0.0640, 3, 'dist_norm2', 'kd_tree');
COPY output_blobs_03d_3c_200s_1600000p TO '/home/gpadmin/madlib/src/ports/postgres/modules/dbscan/test/perf/blobs/output_blobs_03d_3c_200s_1600000p.csv' CSV HEADER;
