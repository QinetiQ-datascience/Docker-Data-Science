#!/bin/bash
set -e

cd /tmp && wget --quiet https://repo.continuum.io/archive/$ANACONDA -O /tmp/anaconda.sh
bash /tmp/anaconda.sh -f -b -p $CONDA_DIR && rm /tmp/anaconda.sh
