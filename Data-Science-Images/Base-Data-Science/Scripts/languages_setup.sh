#!/bin/bash
set -e

cd $CONDA_SRC && git clone git://github.com/jedisct1/libsodium.git && cd libsodium && git checkout e2a30a && ./autogen.sh && ./configure && make check && make install && ldconfig
cd $CONDA_SRC && git clone --depth 1 git://github.com/zeromq/libzmq.git && cd libzmq && ./autogen.sh && ./configure && make -j 4
cd $CONDA_SRC/libzmq && make check
cd $CONDA_SRC/libzmq && make install && ldconfig
rm -rf $CONDA_SRC/libsodium && rm -rf $CONDA_SRC/libzmq

apt update && apt --yes install octave scala

# Show Julia where conda libraries are andß Create JULIA_PKGDIR 
echo "deb http://ppa.launchpad.net/staticfloat/juliareleases/ubuntu trusty main" > /etc/apt/sources.list.d/julia.list && \
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3D3D3ACC && \
apt update && \
apt install -y --no-install-recommends \
julia && apt clean && \
rm -rf /var/lib/apt/lists/* && \

echo "push!(Libdl.DL_LOAD_PATH, \"$CONDA_DIR/lib\")" >> /usr/etc/julia/juliarc.jl && \

mkdir $JULIA_PKGDIR && \
chown -R $DATASCI_USER:$DATASCI_USER $JULIA_PKGDIR
ln -s $JULIA_PKGDIR/julia /usr/local/bin/julia

cd /opt && curl -sSL https://get.haskellstack.org/ | sh && \
git clone https://github.com/gibiansky/IHaskell && \
chown -R $DATASCI_USER:$DATASCI_USER $IHaskell

npm install -g ijavascript

mkdir -p /usr/lib/node_modules/ijavascript/node_modules/zeromq/zmq
chown -R $DATASCI_USER:$DATASCI_USER /usr/lib/node_modules/