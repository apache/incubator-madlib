#!/usr/bin/env python

import agate
import warnings
warnings.resetwarnings()  # Undo damage done by agate!

import sys
import re
import numpy as np
import time
from sklearn.cluster import DBSCAN
from sklearn import metrics
from sklearn.datasets import make_blobs

if (len(sys.argv) == 2):
    input_filename = sys.argv[1]
else:
    print("Usage: {} INPUT_FILENAME".format(sys.argv[0]))

tbl = agate.Table.from_csv(input_filename)
print("Loaded input csv.")
points = [ map(float, row['point'][1:-1].split(',')) for row in tbl ]
X = np.array(points)
labels_true = [ int(row['true_cluster']) for row in tbl ]

# Compute DBSCAN
start_clock = time.clock()
start_time = time.time()
print("Starting DBSCAN at {}...".format(start_time))
db = DBSCAN(eps=0.3, min_samples=10).fit(X)
print("CPU time: {}".format(time.clock() - start_clock))
print("Real time: {}".format(time.time() - start_time))

core_samples_mask = np.zeros_like(db.labels_, dtype=bool)
core_samples_mask[db.core_sample_indices_] = True
labels = db.labels_

# Number of clusters in labels, ignoring noise if present.
n_clusters_ = len(set(labels)) - (1 if -1 in labels else 0)
n_noise_ = list(labels).count(-1)

if n_clusters_ < 2:
    print("Only found {} clusters :-(  Halting".format(n_clusters_))
    sys.exit(-1)

print('Estimated number of clusters: %d' % n_clusters_)
print('Estimated number of noise points: %d' % n_noise_)
print("Homogeneity: %0.3f" % metrics.homogeneity_score(labels_true, labels))
print("Completeness: %0.3f" % metrics.completeness_score(labels_true, labels))
print("V-measure: %0.3f" % metrics.v_measure_score(labels_true, labels))
print("Adjusted Rand Index: %0.3f"
      % metrics.adjusted_rand_score(labels_true, labels))
print("Adjusted Mutual Information: %0.3f"
      % metrics.adjusted_mutual_info_score(labels_true, labels))
print("Silhouette Coefficient: %0.3f"
      % metrics.silhouette_score(X, labels))

