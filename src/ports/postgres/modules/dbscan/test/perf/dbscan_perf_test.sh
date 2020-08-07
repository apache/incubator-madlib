#!/bin/bash
npoints=100000
for i in {2..8}
do
    dim=$((i*i))
    nclusters=$((i+2))
    sigma=0$((echo "scale=2"; echo "0.3/$i") | bc)
    fname="${dim}d_${nclusters}c_${sigma}s_${npoints}p"
    echo ./gen_clusters.py "$blobfile" "$dim" ${nclusters} $sigma $npoints
    ./gen_clusters.py "$dim" "${nclusters}" "$sigma" "$npoints" > "stats/sklearn_${fname}.txt" &&\
    ./dbscan_sklearn.py "blobs/input_blobs_${fname}.csv" >> "stats/sklearn_${fname}.txt"
    if [ $? -ne 0 ]
    then
        echo Stopping perf run early.
        exit -1
    fi
    echo ./dbscan_sklearn.py input_blobs_${fname}.csv
done
