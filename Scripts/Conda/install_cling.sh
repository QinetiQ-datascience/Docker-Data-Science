#!/bin/bash
set -e

sudo git clone --depth 1 https://github.com/minrk/clingkernel.git && sudo chown -R $DATASCI_USER:$DATASCI_USER $Cling