FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04
##
##  Influeces taken from:
##  
##	* jupyter/docker-stacks
##	* Kaggle/docker-python
##	* Kaggle/docker-rstats
##	* Kaggle/docker-julia

MAINTAINER Josh Cole <jwcole1@qinetiq.com>

# Configure environment
ENV DEBIAN_FRONTEND=noninteractive SHELL=/bin/bash NAME=ubuntu-base-data-science

# The Basics
RUN	apt-get update && apt-get --yes upgrade && apt-get --yes install aptitude apt-utils sudo locales && \
apt-get clean all && rm -rf /var/lib/apt/lists/*

# Locale
RUN sed -i -e 's/# en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen

ENV LANG=en_GB.UTF-8 LANGUAGE=en_GB:en  LC_ALL=en_GB.UTF-8

ENV DATASCI_USER=datasci DATASCI_UID=1000 
ENV HOME=/home/$DATASCI_USER
ENV CONDA_DIR=/opt/conda CONDA_SRC=/usr/local/src/conda
ENV CONDA_BIN=$CONDA_DIR/bin 
ENV PATH $CONDA_BIN:$HOME/.local/bin:$PATH
ENV Documents=$HOME/Documents Downloads=$HOME/Downloads Workspace=$HOME/Workspace

ADD Scripts/Linux_Config/setup_datasci_user.sh /tmp/setup_datasci_user.sh
RUN bash /tmp/setup_datasci_user.sh

VOLUME ["$Documents", "$Downloads", "$Workspace"]
RUN apt-get update && apt-get install -yq --no-install-recommends \
    wget \
    bzip2 \
    unzip \
    libgmp3-dev \
    ca-certificates \
    fonts-liberation \
    software-properties-common \
    python-software-properties \
    build-essential \
    automake \
    autotools-dev \
    cmake  \
    gnuplot \
    ghostscript \
    graphviz \
    less \
    net-tools \
    libboost-all-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Version control
RUN apt-get update && apt-get install --yes git subversion mercurial && apt-get clean all && rm -rf /var/lib/apt/lists/*
RUN chown -R $DATASCI_USER:$DATASCI_USER /opt

USER $DATASCI_USER
ENV ANACONDA_VERSION=Anaconda3-4.4.0-Linux-x86_64

ADD Scripts/Conda/install_anaconda.sh /tmp/install_anaconda.sh
RUN bash /tmp/install_anaconda.sh

RUN $CONDA_BIN/conda install --yes -c bioconda java-jdk sbt

RUN $CONDA_BIN/conda install --yes -c conda-forge \
	nodejs \
	r-essentials \
	r-xgboost \
	r-irkernel \
	r-devtools \
	r-codetools \
	r-cvtools \
	r-udunits2 \
	octave \
	stack

RUN $CONDA_BIN/conda install --yes -c anaconda-cluster scala
RUN $CONDA_BIN/conda install --yes -c bioconda julia && \
	julia -e 'Pkg.init()' && \
	julia -e 'Pkg.update()' && \
	julia -e 'Pkg.add("HDF5")' && \
	julia -e 'Pkg.add("Gadfly")' && \
	julia -e 'Pkg.add("RDatasets")' && \
	julia -e 'Pkg.add("IJulia")' && \

	julia -e 'using HDF5' && \
	julia -e 'using Gadfly' && \
	julia -e 'using RDatasets' && \
	julia -e 'using IJulia'

ENV IHaskell=/opt/IHaskell

# RUN $CONDA_BIN/conda install --yes -c bioconda ghc
RUN stack setup
RUN stack config set system-ghc --global true

RUN cd /opt && git clone https://github.com/gibiansky/IHaskell
RUN cd $IHaskell && stack install gtk2hs-buildtools

USER root 
RUN apt-get update && apt-get --yes install libghc-magic-dev libblas-dev liblapack-dev gfortran pkg-config libcairo2-dev libmagic-dev libghc-pango-dev libpango1.0-dev libzmq-dev libtool-bin

RUN cd $CONDA_SRC && git clone git://github.com/jedisct1/libsodium.git && cd libsodium && git checkout e2a30a && ./autogen.sh && ./configure && make check && make install && ldconfig
RUN cd $CONDA_SRC && git clone --depth 1 git://github.com/zeromq/libzmq.git && cd libzmq && ./autogen.sh && ./configure && make -j 4
RUN cd $CONDA_SRC/libzmq && make check
RUN cd $CONDA_SRC/libzmq && make install && ldconfig
RUN rm -rf $CONDA_SRC/libsodium && rm -rf $CONDA_SRC/libzmq
USER $DATASCI_USER

RUN cd $IHaskell && stack install --fast
RUN cd $IHaskell && stack exec ihaskell -- install --stack 

# Might be bad to blindly update all packages
ADD Scripts/Conda/update_conda_pip_pkgs.sh /tmp/update_conda_pip_pkgs.sh
RUN bash /tmp/update_conda_pip_pkgs.sh

RUN $CONDA_BIN/conda install --yes -c anaconda boost

ADD Scripts/Jupyter/install_jupyter_widgets.sh /tmp/install_jupyter_widgets.sh
RUN bash /tmp/install_jupyter_widgets.sh

# USER root

# ENV SAGE_ROOT=/usr/lib/sagemath/ JUPYTER_SHARE=/usr/local/share/jupyter USER_JUPYTER_KERNELS=$HOME/.jupyter/kernels

# ADD Scripts/SageMath/install_sagemath.sh /tmp/install_sagemath.sh
# RUN bash /tmp/install_sagemath.sh



# ENV IHaskell=/opt/IHaskell
# cd /opt && curl -sSL https://get.haskellstack.org/ | sh && \
# git clone https://github.com/gibiansky/IHaskell && \
# chown -R $DATASCI_USER:$DATASCI_USER $IHaskell

# su - $DATASCI_USER && cd $IHaskell && \
# stack setup && \
# stack config set system-ghc --global true && \
# stack install gtk2hs-buildtools && \
# stack install --fast && \
# stack exec ihaskell -- install --stack && exit

# USER $DATASCI_USER

# RUN mv $HOME/.local/share/jupyter/kernels/* $CONDA_DIR/share/jupyter/kernels/

# SHA Currently failing
# ENV TINI_VERSION=v0.15.0 TINI_CHECKSUM=595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 TINI_DIR=/opt/tini

# ADD Scripts/Linux_Config/linux_configuration.sh /tmp/linux_configuration.sh
# RUN bash /tmp/linux_configuration.sh

# Additional Languages

# USER $DATASCI_USER

USER root 

# ~~~~ CLEAN UP ~~~~
RUN apt-get update && apt-get --yes upgrade && apt-get --yes autoremove && apt-get clean && \
	rm -rf /var/lib/apt-get/lists/* && \
	rm -rf /src/*.deb && \
    rm -rf $CONDA_SRC/* && \
    rm -rf /tmp/*

# RUN chown -R $DATASCI_USER:$DATASCI_USER $HOME

COPY Scripts/Jupyter/jupyter_notebook_config.py /etc/jupyter/
RUN chown -R $DATASCI_USER:$DATASCI_USER /etc/jupyter/

# Expose Port For Jupyter
EXPOSE 8888-9000

USER $DATASCI_USER


RUN rm -rf $HOME/.cache/pip/* && $CONDA_BIN/conda clean -i -l -t --yes

# ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/bin/bash"]

# Add checksums where possible
# Edit /etc/docker/daemon.json. If it does not yet exist, create it. Assuming that the file was empty, add the following contents.

# {
#   "storage-driver": "overlay2"
# }
