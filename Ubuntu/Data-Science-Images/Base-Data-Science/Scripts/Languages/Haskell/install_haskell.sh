#!/bin/bash
set -e

cd /opt && curl -sSL https://get.haskellstack.org/ | sh && \
git clone https://github.com/gibiansky/IHaskell && \
chown -R $DATASCI_USER:$DATASCI_USER $IHaskell

su $DATASCI_USER -c "cd $IHaskell && \
stack setup && \
stack config set system-ghc --global true && \
stack install gtk2hs-buildtools && \
stack install --fast && \
stack exec ihaskell -- install --stack"