#!/bin/bash
set -e

# Show Julia where conda libraries are andß Create JULIA_PKGDIR 
echo "deb http://ppa.launchpad.net/staticfloat/juliareleases/ubuntu trusty main" > /etc/apt/sources.list.d/julia.list && \
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3D3D3ACC && \
apt-get update && apt-get install -y --no-install-recommends \
julia && apt-get clean && \
rm -rf /var/lib/apt/lists/* && \

echo "push!(Libdl.DL_LOAD_PATH, \"$CONDA_DIR/lib\")" >> /usr/etc/julia/juliarc.jl && \

mkdir $JULIA_PKGDIR && \
chown -R $DATASCI_USER:$DATASCI_USER $JULIA_PKGDIR
ln -s $JULIA_PKGDIR/julia /usr/local/bin/julia

su - $DATASCI_USER - c "bash /tmp/install_julia_base_pkgs.sh"