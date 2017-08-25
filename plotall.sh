#!/bin/bash

ARCHIVE=results.zip
BASE=`pwd`

mkdir -p $BASE/cluster_impurity/results
cd $BASE/cluster_impurity/results
unzip ../../$ARCHIVE 'cluster_impurity/*'
cd cluster_impurity
echo *.tsv | xargs -n1 Rscript ../../plot.R
Rscript ../../plot_comparison.R

mkdir -p $BASE/cluster_size/results
cd $BASE/cluster_size/results
unzip ../../$ARCHIVE 'cluster_size/*'
cd cluster_size
echo *.tsv | xargs -n1 Rscript ../../plot.R
Rscript ../../plot_comparison.R

mkdir -p $BASE/clusters_owned/results
cd $BASE/clusters_owned/results
unzip ../../$ARCHIVE 'clusters_owned/*'
cd clusters_owned
echo *.tsv | xargs -n1 Rscript ../../plot.R
Rscript ../../plot_comparison.R

mkdir -p $BASE/individuals_location/results
cd $BASE/individuals_location/results
unzip ../../$ARCHIVE 'individuals_location/*'
cd individuals_location
echo *.tsv | xargs -n1 Rscript ../../plot.R
Rscript ../../plot_comparison.R

mkdir -p $BASE/interedges_cc/results
cd $BASE/interedges_cc/results
unzip ../../$ARCHIVE 'interedges_cc/*'
cd interedges_cc
echo *.tsv | xargs -n1 Rscript ../../plot.R
Rscript ../../plot_comparison.R

mkdir -p $BASE/interedges_forest/results
cd $BASE/interedges_forest/results
unzip ../../$ARCHIVE 'interedges_forest/*'
cd interedges_forest
echo *.tsv | xargs -n1 Rscript ../../plot.R
Rscript ../../plot_comparison.R

# mkdir -p $BASE/subcluster_individuals/results
# cd $BASE/subcluster_individuals/results
# unzip ../../$ARCHIVE 'subcluster_individuals/*'
# cd subcluster_individuals
# echo *.tsv | xargs -n1 Rscript ../../plot.R
# Rscript ../../plot_comparison.R
