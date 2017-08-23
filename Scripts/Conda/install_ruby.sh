#!/bin/bash
set -e

conda install --yes -c conda-forge pkg-config libtool zeromq gettext pcre libuuid 

cd $CONDA_SRC && git clone git://github.com/jedisct1/libsodium.git && cd libsodium && ./autogen.sh && ./configure && make check && make install && sudo ldconfig
cd $CONDA_SRC && git clone git://github.com/zeromq/libzmq.git && cd libzmq && ./autogen.sh && ./configure && make check && make install && sudo ldconfig
cd $CONDA_SRC && git clone https://github.com/zeromq/czmq && cd czmq && ./autogen.sh && ./configure && make && make install && sudo ldconfig

cd $CONDA_SRC && sudo rm -rf $CONDA_SRC/libsodium && sudo rm -rf $CONDA_SRC/libzmq && sudo rm -rf $CONDA_SRC/czmq

conda install --yes -c conda-forge ruby

gem update --system
gem update bundler
gem install cztop iruby gnuplot nyaplot rubyvis awesome_print pry pry-doc && iruby register --force
