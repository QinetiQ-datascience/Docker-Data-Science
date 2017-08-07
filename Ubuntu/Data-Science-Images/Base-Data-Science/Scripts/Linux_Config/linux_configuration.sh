#!/bin/bash
set -e

# Dev Tools
apt-get update && apt-get --yes install software-properties-common python-software-properties build-essential automake autotools-dev && \
apt-get clean all && rm -rf /var/lib/apt/lists/*

apt-get update && apt-get --yes install  wget curl unzip zip bzip2 fonts-liberation python-dev libjpeg8-dev zlib1g-dev gfortran  fonts-dejavu ca-certificates \
libcairo2 libpango1.0-0 libpcre3-dev gettext hdf5-tools m4 libssl-dev libcurl4-openssl-dev libzmq3-dev cmake unzip libsm6 jed emacs libxrender1 \
libtinfo-dev libcairo2-dev libpango1.0-dev libmagic-dev libblas-dev liblapack-dev libzmq3-dev libgmp-dev libffi-dev libunwind-dev \
ghostscript gnuplot graphviz less xvfb net-tools && apt-get clean all && rm -rf /var/lib/apt/lists/*

sudo apt-get update && sudo apt-get install --yes \
libblas-dev \
liblapack-dev \
libatlas-base-dev \
libxss1 \
libgconf-2-4 \
libnss3 \
libasound2 \
libgl1-mesa-dri \
libgl1-mesa-glx && \
apt-get clean all && rm -rf /var/lib/apt/lists/*

# Version control
apt-get update && apt-get install --yes git subversion mercurial && apt-get clean all && rm -rf /var/lib/apt/lists/*

# Documentation generation requirements for jupyter
apt-get update && apt-get --yes install texlive texlive-latex-base texlive-latex-extra texlive-fonts-extra texlive-fonts-recommended texlive-generic-recommended pandoc && \
apt-get clean all && rm -rf /var/lib/apt/lists/*

# Install Boost
apt-get update && add-apt-repository universe && apt-get update && apt-get --yes install   && \
apt-get clean all && rm -rf /var/lib/apt/lists/*


