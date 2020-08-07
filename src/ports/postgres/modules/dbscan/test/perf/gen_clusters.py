#!/usr/bin/env python

import csv
import sys
import numpy as np
import random
import math

from sklearn.datasets import make_blobs
from sklearn.preprocessing import StandardScaler

if len(sys.argv) > 2:
    dim = int(sys.argv[1])
    nclusters = int(sys.argv[2])
    sigma = float(sys.argv[3])
    npoints = int(1000)
    if len(sys.argv) == 5:
        npoints = int(sys.argv[4])
else:
    print("Usage: {} DIMENSIONS CLUSTERS SIGMA [POINTS]".format(sys.argv[0]))
    sys.exit(-1)

def dist_squared(x, y):
    d = [ (yy - xx) * (yy - xx) for xx,yy in zip(x,y) ]
    return sum(d)

print("Choosing {} cluster centers...".format(nclusters))
centers = []
mask = int(math.pow(2, dim))
used = set()
if nclusters > mask:
    print("Too many clusters for d={}, maximum is {}".format(dim,mask))
    sys.exit(-1)

for cluster in range(nclusters):
    while len(used) < mask:
        c = random.randint(0, mask)
        if c not in used:
            used.add(c)
            break

    center = []
    for bit in range(dim):
        center.append(1 if (1 << bit) & c else -1 )
    centers.append(center)

for i, c in enumerate(centers):
    print("c{}: {}".format(i, c))

for i in range(len(centers)):
    for j in range(i + 1, len(centers)):
        a = centers[i]
        b = centers[j]
        print("| c{} - c{} |^2 = {}".format(i, j, dist_squared(a, b)))

print ("Generating {} points in {} clusters with sigma={}...".format(npoints, nclusters, sigma))
X, labels_true = make_blobs(n_samples=npoints, centers=centers, cluster_std=sigma,
                            random_state=0)

#X = StandardScaler().fit_transform(Xunscaled).tolist()
#centers = StandardScaler().fit_transform(centers).tolist()

points = map(lambda xi : '{' + ','.join(map(str, xi)) + '}', X)

data = [ {'id' : i, 'point' : points[i], 'true_cluster' : labels_true[i] } for i in range(len(labels_true)) ]

output_filename = "blobs/input_blobs_{0:02}d_{1}c_{2:03}s_{3}p.csv".format(dim, nclusters, int(1000*sigma), npoints)

s = 0.0
n= 0
print("Sample of small distances btw points:")
m = 100.0
for i in range(len(X[:5000:10])):
    for j in range(len(X[:5000:10])):
        if i == j:
            continue
        d = math.sqrt(dist_squared(X[i],X[j]))
        s += d
        n += 1
        if d < m:
            m = d
            print(m)
print("Avg distance between any 2 points: {}".format(s/n))

with open(output_filename, 'w') as f:
    dw = csv.DictWriter(f, ['id', 'point', 'sklearn_cluster', 'madlib_cluster', 'true_cluster'])
    dw.writeheader()
    dw.writerows(data)

print("Wrote {} points to {}".format(npoints, output_filename))
