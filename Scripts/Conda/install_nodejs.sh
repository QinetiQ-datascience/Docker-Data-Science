#!/bin/bash
set -e

conda install --yes -c conda-forge nodejs 

npm install -g itypescript && its --hide-undefined --ts-install=global
npm install -g ijavascript && ijsinstall --install=global