#!/bin/bash
set -e

# Anaconda install Options
# -b           install in batch mode (without manual intervention),
#              it is expected the license terms are agreed upon
# -f           no error if install prefix already exists (force)
# -h           print this help message and exit
# -p PREFIX    install prefix, defaults to /home/$USER/anaconda3

# Install conda as datasci
cd /tmp && \
wget --quiet https://repo.continuum.io/archive/Anaconda3-4.4.0-Linux-x86_64.sh -O /tmp/anaconda.sh && \
/bin/bash /tmp/anaconda.sh -f -b -p $CONDA_DIR && \
rm /tmp/anaconda.sh && \
$CONDA_DIR/bin/conda config --system --add channels conda-forge && \
$CONDA_DIR/bin/conda config --system --set auto_update_conda false && \
$CONDA_DIR/bin/conda clean -tipsy

$CONDA_DIR/bin/conda update --quiet --yes \
    "conda" \
    "anaconda" 

$CONDA_BIN/conda update --yes setuptools
$CONDA_BIN/pip install --upgrade pip
$CONDA_BIN/conda install --yes icu=58 --channel conda-forge