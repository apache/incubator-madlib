#!/bin/bash
DB="dbscan"
CWD=$(pwd)
psql $DB -c "DROP TABLE IF EXISTS input_blobs_template CASCADE; CREATE TABLE input_blobs_template (id INTEGER, point DOUBLE PRECISION[], madlib_cluster INTEGER, sklearn_cluster INTEGER, true_cluster INTEGER)"
psql $DB -c "DROP TABLE IF EXISTS output_blobs_template CASCADE; CREATE TABLE output_blobs_template (id INTEGER, point DOUBLE PRECISION[], madlib_cluster INTEGER, leaf_id BIT(16))"
for blobfile in blobs/input*.csv
do
    out_tbl_name=$(basename $blobfile .csv)
    in_tbl_name=$(basename $blobfile .csv)
    psql $DB -c "DROP TABLE IF EXISTS \"$out_tbl_name\" CASCADE"
    psql $DB -c "DROP TABLE IF EXISTS \"$in_tbl_name\" CASCADE"
done
