#!/bin/bash

time bjec run -c conf.yaml tests.py cluster_impurity
mkdir -p cluster_impurity
mv cluster_impurity.* cluster_impurity

time bjec run -c conf.yaml tests.py cluster_size
mkdir -p cluster_size
mv cluster_size.* cluster_size

time bjec run -c conf.yaml tests.py clusters_owned
mkdir -p clusters_owned
mv clusters_owned.* clusters_owned

time bjec run -c conf.yaml tests.py interedges_cc
mkdir -p interedges_cc
mv interedges_cc.* interedges_cc

time bjec run -c conf.yaml tests.py interedges_forest
mkdir -p interedges_forest
mv interedges_forest.* interedges_forest

time bjec run -c conf.yaml tests.py subcluster_individuals
mkdir -p subcluster_individuals
mv subcluster_individuals.* subcluster_individuals

time tar -cjf results.tar.bz2 cluster_impurity cluster_size clusters_owned interedges_cc interedges_forest subcluster_individuals
