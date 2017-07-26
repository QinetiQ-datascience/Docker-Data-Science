#!/bin/bash
set -e

# Dev Tools
apt --yes update && apt --yes install software-properties-common python-software-properties build-essential automake
apt --yes update && apt --yes install  wget curl unzip zip bzip2 fonts-liberation python-dev libjpeg8-dev zlib1g-dev gfortran  fonts-dejavu ca-certificates \
	libcairo2 libpango1.0-0 libpcre3-dev gettext hdf5-tools m4 libssl-dev libcurl4-openssl-dev libzmq3-dev cmake unzip libsm6 jed emacs libxrender1 \
	libtinfo-dev libcairo2-dev libpango1.0-dev libmagic-dev libblas-dev liblapack-dev --no-install-recommends libzmq3-dev libgmp-dev libffi-dev

# Install Java
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
	add-apt-repository --yes ppa:webupd8team/java && \
	apt --yes update && \
	apt install --yes  oracle-java8-installer oracle-java8-set-default && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/cache/oracle-jdk8-installer

# Install Nodejs
# curl -sL https://deb.nodesource.com/setup_8.x | bash - &&  apt update && apt --yes install nodejs
apt --yes update && apt install --yes nodejs-legacy npm

# Version control
apt --yes update && apt install --yes git subversion mercurial --no-install-recommends

# Documentation generation requirements for jupyter
apt --yes update && apt --yes install texlive texlive-latex-base texlive-latex-extra texlive-fonts-extra texlive-fonts-recommended texlive-generic-recommended pandoc --no-install-recommends

apt --yes update && apt --yes install graphviz gnuplot --fix-missing

# Install Boost
apt --yes update && add-apt-repository universe && apt --yes update && apt --yes install  libboost-all-dev