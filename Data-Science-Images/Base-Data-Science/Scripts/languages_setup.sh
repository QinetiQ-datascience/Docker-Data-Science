apt update && apt --yes install libzmq-dev libgmp-dev libffi-dev

cd $CONDA_SRC && git clone https://github.com/zeromq/libzmq \
&& cd $CONDA_SRC/libzmq && mkdir cmake-build

cd $CONDA_SRC/libzmq/cmake-build \
&& cmake .. && make -j 4 \
&& make test && make install && ldconfig \
rm -rf $CONDA_SRC/libzmq

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

cd /opt && curl -sSL https://get.haskellstack.org/ | sh \
	&& git clone https://github.com/gibiansky/IHaskell \
	&& chown -R $DATASCI_USER:$DATASCI_USER $IHaskell