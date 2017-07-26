#!/bin/bash
set -e

useradd -m --shell /bin/bash --uid $DATASCI_UID --user-group $DATASCI_USER 

mkdir -p $CONDA_DIR && chown $DATASCI_USER $CONDA_DIR

# Change ownership
chown -R $DATASCI_USER:$DATASCI_USER $CONDA_DIR

# Users passwords
echo "$DATASCI_USER:$DATASCI_USER"|chpasswd && adduser $DATASCI_USER sudo
echo "root:Docker!" | chpasswd
mkdir -p $CONDA_SRC && chown -R $DATASCI_USER:$DATASCI_USER $CONDA_SRC
mkdir -p $Documents && chown -R $DATASCI_USER:$DATASCI_USER $Documents
mkdir -p $Downloads && chown -R $DATASCI_USER:$DATASCI_USER $Downloads
mkdir -p $Workspace && chown -R $DATASCI_USER:$DATASCI_USER $Workspace