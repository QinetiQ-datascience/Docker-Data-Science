#!/bin/bash
set -e

# Install Nodejs
apt-get update && apt-get install --yes nodejs-legacy npm

npm install -g ijavascript

su - $DATASCI_USER -c "ijsinstall"