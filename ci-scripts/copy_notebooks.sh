#!/usr/bin/env bash
# Copyright (c) 2017, openradar developers.
# Distributed under the BSD 3-Clause license. See LICENSE for more info.

cd $OPENRADAR_NOTEBOOKS
# get notebooks list
notebooks=`find notebooks -path notebooks/*.ipynb_checkpoints -prune -o -name *.ipynb -print`
echo $notebooks

# copy notebooks to doc/sources
for nb in $notebooks; do
    cp --parents $nb $OPENRADAR_BUILD_DIR/doc/source/
done

# copy images to docs too
images=`find notebooks -path notebooks/*.ipynb_checkpoints -prune -o -name *.png -print`
echo $images
for im in $images; do
    cp --parents $im $OPENRADAR_BUILD_DIR/doc/source/
done