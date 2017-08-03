FROM nvidia/cuda:8.0-cudnn6-devel-centos7
##
##  Influeces taken from:
##  
##	* jupyter/docker-stacks
##	* Kaggle/docker-python
##	* Kaggle/docker-rstats
##	* Kaggle/docker-julia

MAINTAINER Josh Cole <jwcole1@qinetiq.com>

# Configure environment
ENV DEBIAN_FRONTEND=noninteractive SHELL=/bin/bash NAME=centos-base-data-science
RUN yum update -y &&  yum install -y epel-release && yum clean all && rm -rf /var/lib/apt/lists/*
RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && yum clean all && rm -rf /var/lib/apt/lists/*
# The Basics
RUN	yum -y update && yum -y upgrade && yum -y install yum-utils sudo locales && \
yum clean all && rm -rf /var/lib/apt/lists/*

# # Locale
# RUN sed -i -e 's/# en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/' /etc/locale.gen && \
#     locale-gen
RUN localedef -i en_GB -f UTF-8 en_GB.UTF-8
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
RUN yum -y update && yum install -y \
    wget \
    bzip2 \
    unzip \
    ca-certificates \
    fonts-liberation \
    software-properties-common \
    python-software-properties && \
    yum clean all && \
    rm -rf /var/lib/apt/lists/*

RUN yum -y update && yum-builddep -y octave && \
    yum clean all && \
    rm -rf /var/lib/apt/lists/*

# Version control
RUN yum -y update && yum install -y git subversion mercurial && yum clean all && rm -rf /var/lib/apt/lists/*

RUN yum -y update && yum install -y install texlive texlive-latex-base texlive-latex-extra texlive-fonts-extra texlive-fonts-recommended texlive-generic-recommended pandoc && \
yum clean all && rm -rf /var/lib/apt/lists/*

ENV IHaskell=/opt/IHaskell
RUN cd /opt && git clone https://github.com/gibiansky/IHaskell && chown -R $DATASCI_USER:$DATASCI_USER $IHaskell

ENV Cling=/opt/clingkernel
RUN cd /opt && git clone --depth 1 https://github.com/minrk/clingkernel.git && chown -R $DATASCI_USER:$DATASCI_USER $Cling

USER $DATASCI_USER
ENV ANACONDA_VERSION=Anaconda3-4.4.0-Linux-x86_64

ADD Scripts/Conda/install_anaconda.sh /tmp/install_anaconda.sh
RUN bash /tmp/install_anaconda.sh

RUN $CONDA_BIN/conda create --yes -n sagemath python=2.7 
RUN bash -c "source activate sagemath && $CONDA_BIN/conda install --yes -c conda-forge sagelib && source deactivate sagemath"
RUN conda install --yes -c pstey julia julia-bindeps
# Languages
RUN $CONDA_BIN/conda install --yes -c conda-forge \
    nodejs \
    octave \
    perl \
    ruby \
    stack \
    r-essentials \
    r-xgboost \
    r-irkernel \
    r-devtools \
    r-codetools \
    r-cvtools \
    r-udunits2 \
    r-rstudioapi

RUN $CONDA_BIN/conda install --yes -c jeremyschlatter golang

RUN conda install --yes -c creditx gcc-7
RUN $CONDA_BIN/conda install --yes -c bioconda java-jdk sbt graphicsmagick perl-gd scala

RUN $CONDA_BIN/conda install --yes -c conda-forge cmake autoconf automake pango libtool gnuplot ghostscript graphviz pkg-config \
lapack blas readline xorg-libx11 xorg-libxau xorg-libxdmcp fig2dev libjpeg-turbo pcre arpack curl fftw fontconfig freetype glpk hdf5 \
llvmdev zlib suitesparse qscintilla2 qt libpng lua lua-luaposix lua-luafilesystem xorg-libxrender boost mesalib
# RUN conda install --yes -c conda-forge pyopengl
RUN conda install --yes -c clinicalgraphics osmesa vtk zeromq
RUN conda install --yes -c pkgw/label/superseded modern-xorg-stack
RUN echo "push!(Libdl.DL_LOAD_PATH, \"$CONDA_DIR/lib\")" >> /opt/conda/etc/julia/juliarc.jl

USER root 
RUN yum update -y && yum install -y deltarpm
ADD Scripts/dnf-stack-el7.repo /etc/yum.repos.d/dnf-stack-el7.repo
RUN yum update -y && yum install -y dnf
RUN dnf -y update && dnf install -y dnf-plugins-core copr-cli
RUN dnf -y update && dnf copr enable nalimilan/julia -y
RUN yum -y update && yum install -y ImageMagick ImageMagick-devel ImageMagick-c++ hdf5-devel blosc-devel

USER $DATASCI_USER
# RUN julia -e 'Pkg.init()' && \
#     julia -e 'Pkg.update()' && \
#     julia -e 'Pkg.add("HDF5")' && \
#     julia -e 'Pkg.add("Gadfly")' && \
#     julia -e 'Pkg.add("RDatasets")' && \
#     julia -e 'Pkg.add("IJulia")' && \
#     julia -e 'using HDF5' && \
#     julia -e 'using Gadfly' && \
#     julia -e 'using RDatasets' && \
#     julia -e 'using IJulia'


# RUN conda install --yes -c conda-forge libglu protobuf xorg-xproto

# RUN stack setup
# RUN stack config set system-ghc --global true

# RUN cd $IHaskell && stack install gtk2hs-buildtools

# RUN cd $IHaskell && stack install --fast
# RUN cd $IHaskell && stack exec ihaskell -- install --stack 

# # # # Might be bad to blindly update all packages
# # # ADD Scripts/Conda/update_conda_pip_pkgs.sh /tmp/update_conda_pip_pkgs.sh
# # # RUN bash /tmp/update_conda_pip_pkgs.sh


# ADD Scripts/Jupyter/install_jupyter_widgets.sh /tmp/install_jupyter_widgets.sh
# RUN bash /tmp/install_jupyter_widgets.sh

USER root

# RUN cd $CONDA_SRC && wget https://raw.githubusercontent.com/root-project/cling/master/tools/packaging/cpt.py && \
# chmod +x cpt.py && ./cpt.py --check-requirements && ./cpt.py --create-dev-env Debug --with-workdir=./cling-build/ && \
# rm -rf cling-build && rm cpt.py

# #Redhawk
# ENV REDHAWK_VERSION=2.0.6
# RUN cd $CONDA_SRC && wget https://github.com/RedhawkSDR/redhawk/releases/download/$REDHAWK_VERSION/redhawk-yum-$REDHAWK_VERSION-el7-x86_64.tar.gz && \
# tar xzvf redhawk-yum-$REDHAWK_VERSION-el7-x86_64.tar.gz && cd redhawk-$REDHAWK_VERSION-el7-x86_64 

# ADD Scripts/redhawk.repo /etc/yum.repos.d/redhawk.repo
# RUN cd $CONDA_SRC/redhawk-$REDHAWK_VERSION-el7-x86_64 && sed -i 's@LDIR@'`pwd`'@g' /etc/yum.repos.d/redhawk.repo
# RUN yum -y update && yum groupinstall -y "REDHAWK Development"

# ~~~~ CLEAN UP ~~~~
RUN yum -y update && yum -y upgrade && yum -y autoremove && yum clean all && \
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







# conda install -c conda-forge libblitz