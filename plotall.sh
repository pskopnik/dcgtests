#!/bin/bash

ARCHIVE=results.zip
BASE=`pwd`

cd $BASE/cluster_impurity
mkdir -p results
cd results
unzip ../../$ARCHIVE 'cluster_impurity/*'
cd cluster_impurity
echo *.tsv | xargs -n1 Rscript ../../plot.R
Rscript ../../plot_comparison.R

cd $BASE/cluster_size
mkdir -p results
cd results
unzip ../../$ARCHIVE 'cluster_size/*'
cd cluster_size
echo *.tsv | xargs -n1 Rscript ../../plot.R
Rscript ../../plot_comparison.R

cd $BASE/clusters_owned
mkdir -p results
cd results
unzip ../../$ARCHIVE 'clusters_owned/*'
cd clusters_owned
echo *.tsv | xargs -n1 Rscript ../../plot.R
Rscript ../../plot_comparison.R

cd $BASE/interedges_cc
mkdir -p results
cd results
unzip ../../$ARCHIVE 'interedges_cc/*'
cd interedges_cc
echo *.tsv | xargs -n1 Rscript ../../plot.R
Rscript ../../plot_comparison.R

cd $BASE/interedges_forest
mkdir -p results
cd results
unzip ../../$ARCHIVE 'interedges_forest/*'
cd interedges_forest
echo *.tsv | xargs -n1 Rscript ../../plot.R
Rscript ../../plot_comparison.R

# cd $BASE/subcluster_individuals
# mkdir -p results
# cd results
# unzip ../../$ARCHIVE 'subcluster_individuals/*'
# cd subcluster_individuals
# echo *.tsv | xargs -n1 Rscript ../../plot.R
# Rscript ../../plot_comparison.R
