#!/bin/bash
set -e

conda install --yes -c creditx gcc-7
conda install --yes -c bioconda sbt scala

conda install --yes -c conda-forge pkg-config

cd $CONDA_SRC &&  git clone --depth 1 https://github.com/jupyter-scala/jupyter-scala.git && \
cd jupyter-scala &&  bash ./jupyter-scala && rm -rf $CONDA_SRC/jupyter-scala