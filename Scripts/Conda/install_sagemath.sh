#!/bin/bash
set -e

# Sage Math
conda create --yes -n sagemath python=2.7 anaconda
bash -c "source activate sagemath && conda install --yes -c conda-forge sagelib && source deactivate sagemath"

$SAGEMATH/bin/python -m pip install ipykernel && $SAGEMATH/bin/python -m ipykernel install --name sagemath --display-name "Python 2 (sagemath)"