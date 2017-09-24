#!/usr/bin/env bash
# Copyright (c) 2017, openradar developers.
# Distributed under the BSD 3-Clause license. See LICENSE for more info.

# print the vars
echo "TRAVIS_PULL_REQUEST " $TRAVIS_PULL_REQUEST
echo "TRAVIS_SECURE_ENV_VARS " $TRAVIS_SECURE_ENV_VARS
echo "TRAVIS_TAG " $TRAVIS_TAG ${TRAVIS_TAG:1}

# get and install latest miniconda
wget http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh \
    -O miniconda.sh
chmod +x miniconda.sh
bash miniconda.sh -b -p $HOME/miniconda
export PATH=$HOME/miniconda/bin:$PATH
conda update --yes conda
conda update --yes conda

# Create a testenv with the correct Python version
conda create -n openradar --yes pip python=$PYTHON_VERSION
source activate openradar

# Add conda-forge channel
conda config --add channels conda-forge

# Install openradar dependencies
# atm only wradlib dependencies are pulled
# we might think of using only the conda-forge releases of wradlib, pyart etc-
conda install --yes gdal numpy scipy matplotlib netcdf4 h5py xmltodict

# Install openradar-data
git clone https://github.com/openradar/openradar-cookbooks-data.git $HOME/openradar-data
echo $PWD
ls -lart $HOME
ls -lart $HOME/openradar-data

# Install nbconvert
conda install --yes notebook nbconvert

# Install openradar docu dependencies
if [[ "$DOC_BUILD" == "true" ]]; then
    conda install --yes sphinx numpydoc
    conda install --yes sphinx_rtd_theme
    pip install sphinxcontrib-bibtex
    # install notebook dependencies
    conda install --yes runipy pandoc
    # install nbsphinx
    conda install --yes nbsphinx
fi

# print some stuff
python --version
pip --version

python -c "import numpy; print(numpy.__version__)"
python -c "import numpy; print(numpy.__path__)"
