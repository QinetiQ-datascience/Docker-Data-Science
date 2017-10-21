#!/bin/bash
set -e
conda config --system --add channels conda-forge && \
conda config --system --set auto_update_conda true
conda update --quiet --yes anaconda conda setuptools pip

pip install --upgrade pip

conda install --yes -c conda-forge \
jupyterlab \
jupyterhub \
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
cmake autoconf automake pkg-config texlive-core \
zeromq  icu libtool ncurses boost boost-cpp xgboost

conda clean -tipsy

pip install bash_kernel && python -m bash_kernel.install --sys-prefix
