#!/bin/bash
set -e

cd $CONDA_SRC && git clone git://github.com/jedisct1/libsodium.git && cd libsodium && ./autogen.sh && ./configure && make check && sudo make install && sudo ldconfig
cd $CONDA_SRC && git clone git://github.com/zeromq/libzmq.git && cd libzmq && ./autogen.sh && ./configure && make check && sudo make install && sudo ldconfig
cd $CONDA_SRC && git clone https://github.com/zeromq/czmq && cd czmq && ./autogen.sh && ./configure && make && sudo make install && sudo ldconfig