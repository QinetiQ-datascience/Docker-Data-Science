#!/bin/bash
set -e

useradd -m --shell /bin/bash --uid $DATASCI_UID --user-group $DATASCI_USER 

mkdir -p $CONDA_DIR && chown $DATASCI_USER $CONDA_DIR

# Change ownership
chown -R $DATASCI_USER:$DATASCI_USER $CONDA_DIR

# Users passwords
# echo "$DATASCI_USER:$DATASCI_USER"|chpasswd  && gpasswd -a $DATASCI_USER wheel 
# echo "root:Docker!" | chpasswd

echo "$DATASCI_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
echo "root:$DATASCI_USER" | chpasswd && \
su $DATASCI_USER echo "$DATASCI_USER:$DATASCI_USER" | chpasswd  && gpasswd -a $DATASCI_USER wheel

mkdir -p $CONDA_SRC && chown -R $DATASCI_USER:$DATASCI_USER $CONDA_SRC
mkdir -p $Documents && chown -R $DATASCI_USER:$DATASCI_USER $Documents
mkdir -p $Downloads && chown -R $DATASCI_USER:$DATASCI_USER $Downloads
mkdir -p $Workspace && chown -R $DATASCI_USER:$DATASCI_USER $Workspace