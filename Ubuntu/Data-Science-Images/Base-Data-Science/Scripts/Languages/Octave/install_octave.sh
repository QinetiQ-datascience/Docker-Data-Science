#!/bin/bash
set -e

apt-get update && apt-get --yes build-dep octave liboctave-dev

cd $CONDA_SRC && git clone git://github.com/jedisct1/libsodium.git && cd libsodium && git checkout e2a30a && ./autogen.sh && ./configure && make check && make install && ldconfig
cd $CONDA_SRC && git clone --depth 1 git://github.com/zeromq/libzmq.git && cd libzmq && ./autogen.sh && ./configure && make -j 4
cd $CONDA_SRC/libzmq && make check
cd $CONDA_SRC/libzmq && make install && ldconfig
rm -rf $CONDA_SRC/libsodium && rm -rf $CONDA_SRC/libzmq

apt-get --yes install byacc flex bison
cd $CONDA_SRC/ && wget ftp://ftp.gnu.org/gnu/octave/$OCTAVE_VERSION.tar.gz && \
tar xf $OCTAVE_VERSION.tar.gz && rm $OCTAVE_VERSION.tar.gz && \
cd $OCTAVE_VERSION/ && ./configure && make -j4 && make install
rm -rf $CONDA_SRC/$OCTAVE_VERSION

mkdir -p /usr/lib/node_modules/ijavascript/node_modules/zeromq/zmq
chown -R $DATASCI_USER:$DATASCI_USER /usr/lib/node_modules/

su - $DATASCI_USER - c "$CONDA_BIN/python -m octave_kernel.install"
