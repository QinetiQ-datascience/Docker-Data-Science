#!/bin/bash
set -e

cd /tmp && wget --quiet https://repo.continuum.io/archive/$ANACONDA_VERSION.sh -O /tmp/anaconda.sh
bash /tmp/anaconda.sh -f -b -p $CONDA_DIR && rm /tmp/anaconda.sh

conda config --system --add channels conda-forge && \
conda config --system --set auto_update_conda true
conda update --quiet --yes anaconda conda setuptools pip

conda install --yes -c conda-forge \
ipyleaflet \
bqplot \
pythreejs \
ipyvolume \
cookiecutter \
geopy \
cartopy \
shapely \
rtree \
pyproj \
pyshp \
accelerate \
gdal

conda clean -tipsy

pip install --upgrade pip
pip install ipyleaflet --upgrade
pip install bash_kernel && python -m bash_kernel.install --sys-prefix
