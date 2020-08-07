#!/bin/bash
if [ -n "$1" ]
then
    NUM_POINTS="$1"
else
    echo "Usage $0 NUM_POINTS"
fi
DB="dbscan"
CWD=$(pwd)
echo "\timing on"
for blobfile in blobs/input_blobs*${1}p.csv
do
    tbl_name="$(basename $blobfile .csv)"
    out_tbl_name=${tbl_name/input_/output_}
    echo "DROP TABLE IF EXISTS $out_tbl_name,${out_tbl_name}_summary;"
    echo "SELECT madlib.dbscan('$tbl_name', '$out_tbl_name', 'id', 'point', 0.15, 3, 'squared_dist_norm2', 'kd_tree');"
    echo "COPY $out_tbl_name TO '$CWD/blobs/${out_tbl_name}.csv' CSV HEADER;"
done
