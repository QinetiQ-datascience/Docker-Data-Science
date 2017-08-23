#!/bin/bash
set -e

# Might be bad to blindly update all packages
conda update --all --yes
pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
