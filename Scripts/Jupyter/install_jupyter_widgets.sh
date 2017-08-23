#!/bin/bash
set -e

conda install --yes -c conda-forge ipywidgets=6.0.0
# conda install --yes mathjax
conda install --yes --channel damianavila82 rise
# Configure kernels
jupyter-nbextension install rise --py --sys-prefix
jupyter-nbextension enable rise --py --sys-prefix
jupyter-nbextension enable widgetsnbextension --py --sys-prefix
pip install jupyter_dashboards
jupyter dashboards quick-setup --sys-prefix

# cd $CONDA_SRC && wget https://raw.githubusercontent.com/root-project/cling/master/tools/packaging/cpt.py && \
# chmod +x cpt.py && ./cpt.py --check-requirements && ./cpt.py --create-dev-env Debug --with-workdir=./cling-build/ && \
# rm -rf cling-build && rm cpt.py
# jupyter kernelspec install $Cling/cling --sys-prefix
# 
