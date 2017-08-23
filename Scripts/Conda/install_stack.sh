#!/bin/bash
set -e

conda install --yes -c conda-forge stack

# ensure the right ghc compiler version for Ihaskell, might not be latest
stack upgrade && stack update && stack --resolver ghc-$GHC_VERSION setup --upgrade-cabal --install-ghc && \
stack config set system-ghc --global true && \
cd $IHaskell && stack install gtk2hs-buildtools --install-ghc 

sudo chown -R $DATASCI_USER:$DATASCI_USER $CONDA_DIR

stack upgrade && stack update && stack --resolver ghc-$GHC_VERSION setup --upgrade-cabal --install-ghc && \
stack config set system-ghc --global true && \
cd $IHaskell && stack install gtk2hs-buildtools --install-ghc 
cd $IHaskell && stack --install-ghc install ihaskell && ihaskell install --prefix=$CONDA_DIR