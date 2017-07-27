#!/bin/bash
set -e

$CONDA_BIN/conda install --yes \
   "r-essentials" \
   "r-xgboost" \
   "r-irkernel" \
   "r-devtools" \
   "r-codetools" \
   "r-cvtools" \
   "r-udunits2" 