#!/bin/bash
set -e

conda install --yes -c conda-forge \
	readline \
	octave 

pip install octave_kernel && python -m octave_kernel.install

mv $HOME/.local/share/jupyter/kernels/octave $CONDA_DIR/share/jupyter/kernels