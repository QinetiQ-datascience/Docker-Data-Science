#!/bin/bash
set -e

conda install --yes -c conda-forge pkg-config libtool zeromq gettext pcre libuuid 

cd $CONDA_SRC && sudo rm -rf $CONDA_SRC/libsodium && sudo rm -rf $CONDA_SRC/libzmq && sudo rm -rf $CONDA_SRC/czmq

conda install --yes -c conda-forge ruby

gem update --system
gem update bundler
gem install cztop iruby gnuplot nyaplot rubyvis awesome_print pry pry-doc && iruby register --force
