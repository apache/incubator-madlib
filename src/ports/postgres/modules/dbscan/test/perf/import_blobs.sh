#!/bin/bash
DB="dbscan"
CWD=$(pwd)
psql $DB -c "DROP TABLE IF EXISTS input_blobs_template CASCADE; CREATE TABLE input_blobs_template (id INTEGER, point DOUBLE PRECISION[], madlib_cluster INTEGER, sklearn_cluster INTEGER, true_cluster INTEGER)"
#psql $DB -c "DROP TABLE IF EXISTS output_blobs_template CASCADE; CREATE TABLE output_blobs_template (id INTEGER, point DOUBLE PRECISION[], madlib_cluster INTEGER, leaf_id BIT(16))"
for blobfile in blobs/input*.csv
do
    tbl_name=$(basename $blobfile .csv)
    psql $DB -c "DROP TABLE IF EXISTS \"$tbl_name\" CASCADE"
    psql $DB -c "CREATE TABLE \"$tbl_name\" (LIKE input_blobs_template)"
    psql $DB -c "COPY \"$tbl_name\" FROM '$CWD/$blobfile' CSV HEADER"
done
#for blobfile in blobs/output*.csv
#do
#    tbl_name=$(basename $blobfile .csv)
#    psql $DB -c "DROP TABLE IF EXISTS \"$tbl_name\" CASCADE"
#    psql $DB -c "CREATE TABLE \"$tbl_name\" (LIKE output_blobs_template)"
#    psql $DB -c "COPY \"$tbl_name\" FROM '$CWD/$blobfile' CSV HEADER"
#done
