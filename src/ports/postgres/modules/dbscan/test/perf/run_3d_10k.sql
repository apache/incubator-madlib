\timing on
DROP TABLE IF EXISTS prev_node, prev_node0, prev_node1, prev_node2, prev_node3, prev_node4, prev_node5, prev_node6, prev_node7, prev_node8, prev_node9, prev_node10, prev_node11, prev_node12, prev_node13, prev_node14, prev_node15, prev_node16, prev_node17, prev_node18;
DROP TABLE IF EXISTS output_blobs_03d_3c_200s_10000p, output_blobs_03d_3c_200s_10000p_summary;
-- Signature:  dbscan(source_table character varying, output_table character varying, id_column character varying, expr_point character varying, eps double precision, min_samples integer, metric character varying, algorithm character varying, depth integer)
SELECT madlib.dbscan('input_blobs_03d_3c_200s_10000p', 'output_blobs_03d_3c_200s_10000p', 'id', 'point', 0.1600, 4, 'dist_norm2', 'kd_tree');
COPY output_blobs_03d_3c_200s_10000p TO '/home/gpadmin/madlib/src/ports/postgres/modules/dbscan/test/perf/blobs/output_blobs_03d_3c_200s_10000p.csv' CSV HEADER;
