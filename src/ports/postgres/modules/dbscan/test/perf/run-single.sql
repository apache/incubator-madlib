\timing on
DROP TABLE IF EXISTS output_blobs_03d_3c_200s_10000p,output_blobs_03d_3c_200s_10000p_summary;
SELECT madlib.dbscan('input_blobs_03d_3c_200s_10000p', 'output_blobs_03d_3c_200s_10000p', 'id', 'point', 0.16, 1, 'dist_norm2', 'kd_tree', 5);
--DROP TABLE IF EXISTS output_blobs_25d_7c_006s_10000p,output_blobs_25d_7c_006s_10000p_summary;
--SELECT madlib.dbscan('input_blobs_25d_7c_006s_10000p', 'output_blobs_25d_7c_006s_10000p', 'id', 'point', 0.04, 2, 'dist_norm2', 'kd_tree', 1);
--COPY output_blobs_25d_7c_006s_10000p TO '/home/gpadmin/madlib/src/ports/postgres/modules/dbscan/test/perf/blobs/output_blobs_25d_7c_006s_10000p.csv' CSV HEADER;
