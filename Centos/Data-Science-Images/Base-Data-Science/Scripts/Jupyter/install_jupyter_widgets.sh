#!/bin/bash
set -e

# $CONDA_BIN/conda install --yes mathjax
$CONDA_BIN/conda install --yes --channel damianavila82 rise

# Configure kernels
$CONDA_BIN/jupyter-nbextension install rise --py --sys-prefix
$CONDA_BIN/jupyter-nbextension enable rise --py --sys-prefix
$CONDA_BIN/jupyter-nbextension enable widgetsnbextension --py --sys-prefix
$CONDA_BIN/conda install --yes jupyter_dashboards -c conda-forge
$CONDA_BIN/pip install bash_kernel
$CONDA_BIN/python -m bash_kernel.install

$CONDA_BIN/npm install -g ijavascript
ijsinstall

$CONDA_BIN/pip install octave_kernel
$CONDA_BIN/python -m octave_kernel.install


$CONDA_BIN/jupyter kernelspec install $Cling/cling --user