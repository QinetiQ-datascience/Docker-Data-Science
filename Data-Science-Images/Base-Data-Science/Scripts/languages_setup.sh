apt-get --yes install octave scala

apt-get update && \
	add-apt-repository ppa:staticfloat/julia-deps -y && \
	apt-get update -y && \
	cd /opt && git clone https://github.com/JuliaLang/julia.git && \
	cd julia && \
	echo "JULIA_CPU_TARGET=core2" > Make.user && \
	make -j 4 julia-deps && make -j 4 && make install && \
	chown -R $DATASCI_USER:$DATASCI_USER $JULIA_PKGDIR
	ln -s $JULIA_PKGDIR/julia /usr/local/bin/julia