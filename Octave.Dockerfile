FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04

MAINTAINER Josh Cole <jwcole1@qinetiq.com>

ENV http_proxy "http://wwwproxy.qinetiq.com:80"
ENV https_proxy "http://wwwproxy.qinetiq.com:80"

# Configure environment
ENV DEBIAN_FRONTEND=noninteractive SHELL=/bin/bash NAME=ubuntu-base-data-science DATASCI_USER=datasci DATASCI_UID=1000
ENV HOME=/home/$DATASCI_USER
ENV CONDA_DIR=/opt/conda CONDA_SRC=/usr/local/src/conda
ENV PATH $CONDA_DIR/bin:$HOME/.local/bin:$PATH
ENV IHaskell=/opt/IHaskell Cling=/opt/clingkernel JULIA_PKGDIR=/opt/julia
ENV Documents=$HOME/Documents Downloads=$HOME/Downloads Workspace=$HOME/Workspace
ENV NODE $CONDA_DIR/bin/node

# SHA Currently failing
ENV TINI_VERSION=v0.15.0 TINI_CHECKSUM=595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 TINI_DIR=/opt/tini
ENV JDK_VERSION=8u144

ADD Scripts/Linux/setup_datasci_user.sh /tmp/
RUN bash /tmp/setup_datasci_user.sh

ENV LANG=en_GB.UTF-8 LANGUAGE=en_GB:en  LC_ALL=en_GB.UTF-8

VOLUME ["$Documents", "$Downloads", "$Workspace"]

ENV Jupyter_Share=/usr/local/share/jupyter
RUN mkdir -p $Jupyter_Share && chown -R $DATASCI_USER:$DATASCI_USER $Jupyter_Share
RUN mkdir -p /etc/jupyter && chown -R $DATASCI_USER:$DATASCI_USER /etc/jupyter/

RUN cd /opt/ && wget https://download-cf.jetbrains.com/python/pycharm-community-2017.2.1.tar.gz && tar -xzf pycharm-community-2017.2.1.tar.gz
RUN rm /opt/pycharm-community-2017.2.1.tar.gz
RUN chown -R $DATASCI_USER:$DATASCI_USER /opt/pycharm-community-2017.2.1

USER $DATASCI_USER

ENV ANACONDA_VERSION=Anaconda3-5.0.0-Linux-x86_64 GHC_VERSION=8.2.1 SAGEMATH=/opt/conda/envs/sagemath GOLANG_VERSION=1.8.3

ADD Scripts/Conda/install_conda_base.sh /tmp/
RUN bash /tmp/install_conda_base.sh
RUN conda remove --yes libedit

RUN conda install --yes -c conda-forge cmake autoconf automake pkg-config texlive-core texinfo gcc libgcc libgfortran \
xorg-libxau xorg-libxdmcp xorg-libx11 xorg-xproto xorg-libxext xorg-kbproto xorg-libice \
xorg-libsm xorg-xextproto xorg-libxrender xorg-libxt xorg-libxcb xorg-xcb-proto xorg-libxfixes xorg-libxi \
xorg-util-macros xorg-makedepend xorg-imake xorg-font-util xorg-gccmakedep zeromq  icu readline libtool ncurses

RUN conda clean -tipsy

RUN pip install --upgrade pip
RUN pip install ipyleaflet --upgrade
RUN pip install bash_kernel && python -m bash_kernel.install --sys-prefix

USER root
RUN apt-get update && apt-get install --yes --no-install-recommends libxcomposite-dev
USER $DATASCI_USER

ENV OCTAVE_VERSION=4.2.1
ENV GNUPLOT_VERSION=5.0.*
ADD Scripts/Conda/install_octave.sh /tmp/
RUN bash /tmp/install_octave.sh
RUN cd /tmp &&  wget https://downloads.sourceforge.net/octave/control-3.0.0.tar.gz
RUN cd /tmp &&  wget https://downloads.sourceforge.net/octave/signal-1.3.2.tar.gz
RUN cd /tmp && wget https://downloads.sourceforge.net/octave/statistics-1.3.0.tar.gz
RUN cd /tmp && wget https://downloads.sourceforge.net/octave/io-2.4.7.tar.gz
RUN cd /tmp && octave --eval "pkg install control-3.0.0.tar.gz"
RUN cd /tmp && octave --eval "pkg install signal-1.3.2.tar.gz"
RUN cd /tmp && octave --eval "pkg install io-2.4.7.tar.gz"
RUN conda install --yes -c conda-forge jupyterlab
ADD Scripts/Jupyter/jupyter_notebook_config.py /etc/jupyter/
RUN conda update --all --yes
RUN conda install --yes -c conda-forge xorg-libxtst
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/conda/lib/
# https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
USER root
RUN apt-get update && apt-get install --yes apt-transport-https libreadline-dev
# http://www.unixodbc.org/unixODBC-2.3.4.tar.gz
RUN cd /tmp && wget http://www.unixodbc.org/unixODBC-2.3.4.tar.gz
RUN cd /tmp && tar -zxf unixODBC-2.3.4.tar.gz
RUN cd /tmp/unixODBC-2.3.4 && ./configure --prefix=/usr --sysconfdir=/etc/unixODBC && make && make install
RUN apt-get update && apt-get install --yes libssl1.0.0 libgss3

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list

RUN  apt-get update && ACCEPT_EULA=Y apt-get install --yes msodbcsql
# optional: for bcp and sqlcmd
RUN apt-get update && ACCEPT_EULA=Y apt-get install --yes mssql-tools
RUN apt-get update && apt-get install --yes unixodbc-dev
RUN apt-get update &&  add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt-get update && apt-get upgrade --yes
RUN apt-get update && apt-get install --yes libstdc++6
RUN ldconfig

USER $DATASCI_USER
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
# RUN cd /tmp && wget https://packages.microsoft.com/ubuntu/16.04/prod/pool/main/m/msodbcsql/msodbcsql_13.1.9.1-1_amd64.deb
USER root
ADD Scripts/sql-server/installodbc.sh /tmp/
# RUN cd /tmp && sh installodbc.sh
# .RUN cd /tmp/unixODBC-2.3.4 && ./configure --disable-gui --disable-drivers --enable-iconv --with-iconv-char-enc=UTF8 --with-iconv-ucode-enc=UTF16LE 1 && make && make install
RUN apt-get update && apt-get install --yes iputils-ping
USER $DATASCI_USER
RUN conda install --yes -c conda-forge pymssql
USER root
RUN locale-gen "en_US.UTF-8"
USER $DATASCI_USER
RUN sudo locale-gen "en_US.UTF-8"

RUN pip install blaze --upgrade
RUN pip install graphviz --upgrade

USER root

RUN apt-get update && apt-get install --yes graphviz
RUN apt-get update && apt-get upgrade --yes
USER $DATASCI_USER


# ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/conda/lib
# RUN rm /opt/conda/lib/libtinfo.so.5
# USER root
# RUN cd /tmp && wget https://gallery.technet.microsoft.com/ODBC-Driver-13-for-Ubuntu-b87369f0/file/154097/2/installodbc.sh && sh installodbc.sh
# USER $DATASCI_USER
# RUN source ~/.bashrc
# optional: for unixODBC development headers
