FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04

MAINTAINER Josh Cole <jwcole1@qinetiq.com>

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

ADD Scripts/Linux/setup_datasci_user.sh /tmp/setup_datasci_user.sh
RUN bash /tmp/setup_datasci_user.sh

ENV LANG=en_GB.UTF-8 LANGUAGE=en_GB:en  LC_ALL=en_GB.UTF-8

VOLUME ["$Documents", "$Downloads", "$Workspace"]

ENV Jupyter_Share=/usr/local/share/jupyter
RUN mkdir -p $Jupyter_Share && chown -R $DATASCI_USER:$DATASCI_USER $Jupyter_Share
RUN mkdir -p /etc/jupyter && chown -R $DATASCI_USER:$DATASCI_USER /etc/jupyter/

USER $DATASCI_USER

ENV ANACONDA_VERSION=Anaconda3-4.4.0-Linux-x86_64 GHC_VERSION=8.2.1 SAGEMATH=/opt/conda/envs/sagemath GOLANG_VERSION=1.8.3

ADD Scripts/Conda/install_conda_base.sh /tmp/
RUN bash /tmp/install_conda_base.sh

ADD Scripts/Libraries/install_libs_from_src.sh /tmp/
RUN bash /tmp/install_libs_from_src.sh
RUN conda install --yes -c conda-forge cmake autoconf automake pkg-config
ENV R_HOME=$CONDA_DIR/lib/R
ADD Scripts/Conda/install_r.sh /tmp/
# RUN bash /tmp/install_r.sh

ADD Scripts/R /tmp/R
USER root
# RUN mkdir -p /usr/local/lib/R/etc/
# RUN mv /tmp/R/Rprofile.site $R_HOME/etc/Rprofile.site
# RUN chown $DATASCI_USER:$DATASCI_USER $R_HOME/etc/Rprofile.site
RUN add-apt-repository ppa:jonathonf/gcc-7.1
RUN  apt-get update && apt-get install --yes gcc-7 g++-7

ARG boost_version=1.65.0
ARG boost_dir=boost_1_65_0
ENV boost_version ${boost_version}

RUN wget https://dl.bintray.com/boostorg/release/${boost_version}/source/${boost_dir}.tar.gz \
    && tar xfz ${boost_dir}.tar.gz \
    && rm ${boost_dir}.tar.gz \
    && cd ${boost_dir} \
    && ./bootstrap.sh \
    && ./b2 --without-python --prefix=/usr -j 4 link=shared runtime-link=shared install \
    && cd .. && rm -rf ${boost_dir} && ldconfig

RUN sudo apt-get update && apt-get -y install libreadline-dev libtinfo-dev
USER $DATASCI_USER
RUN conda remove --force --yes readline && pip install readline --upgrade
RUN conda install --channel conda-forge --yes ncurses 
RUN sudo ln -s /bin/tar /bin/gtar
RUN sudo echo "deb http://cran.rstudio.com/bin/linux/ubuntu xenial/" | sudo tee -a /etc/apt/sources.list && gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9 &&  gpg -a --export E084DAB9 | sudo apt-key add -
RUN sudo apt-get update && sudo apt-get --yes install r-base r-base-dev
RUN sudo apt-get update && sudo apt-get --yes install gdebi-core
RUN cd /tmp && wget https://download1.rstudio.org/rstudio-0.99.896-amd64.deb
RUN sudo gdebi -n /tmp/rstudio-0.99.896-amd64.deb && sudo rm /tmp/rstudio-0.99.896-amd64.deb
USER root
RUN apt-get update && \
    (echo N; echo N) | apt-get install -y -f r-cran-rgtk2 && \
    apt-get install -y -f libv8-dev libgeos-dev libgdal-dev libproj-dev \
    libtiff5-dev libfftw3-dev libjpeg-dev libhdf4-0-alt libhdf4-alt-dev \
    libhdf5-dev libx11-dev cmake libglu1-mesa-dev libgtk2.0-dev patch

    # data.table added here because rcran missed it, and xgboost needs it
  RUN R -e 'options(unzip = "internal", repos = c(CRAN = "http://cran.rstudio.com")); \
  install.packages("devtools"); \
  devtools::install_github("hadley/devtools",  branch = "dev"); \
  install.packages("DiagrammeR");'
# 	DiagrammeR \
# 	mefa \
# 	gridSVG \
# 	rgeos \
# 	rgdal \
# 	rARPACK \
# 	prevR \
# 	Amelia \
# 	rattle && \
#     # XGBoost gets special treatment because the nightlies are hard to build with devtools.
#     cd /usr/local/src && git clone --recursive https://github.com/dmlc/xgboost && \
#     cd xgboost && make Rbuild && R CMD INSTALL xgboost_*.tar.gz && \
#     # Prereq for installing udunits2 package; see https://github.com/edzer/units
#     cd /usr/local/src && wget ftp://ftp.unidata.ucar.edu/pub/udunits/udunits-2.2.24.tar.gz && \
#     tar zxf udunits-2.2.24.tar.gz && cd udunits-2.2.24 && ./configure && make && make install && \
#     ldconfig && echo 'export UDUNITS2_XML_PATH="/usr/local/share/udunits/udunits2.xml"' >> ~/.bashrc && \
#     export UDUNITS2_XML_PATH="/usr/local/share/udunits/udunits2.xml" && \
# RUN echo "$(/opt/conda/bin/R CMD javareconf)"
# RUN sudo Rscript /tmp/R/package_installs.R
# # RUN sudo /opt/conda/bin/Rscript /tmp/R/bioconductor_installs.R
# # RUN sudo /opt/conda/bin/Rscript /tmp/R/text_analytics.R
# # RUN sudo /opt/conda/bin/Rscript /tmp/R/install_iR.R

# RUN R -e 'install.packages("xgboost")'
# RUN cd $CONDA_SRC && git clone --recursive https://github.com/dmlc/xgboost && \
# cd xgboost && make Rbuild && R CMD INSTALL xgboost_*.tar.gz

# RUN cd $CONDA_SRC && wget ftp://ftp.unidata.ucar.edu/pub/udunits/udunits-2.2.24.tar.gz && \
# tar zxf udunits-2.2.24.tar.gz && cd udunits-2.2.24 && ./configure && make && make install && \
# ldconfig && echo 'export UDUNITS2_XML_PATH="/usr/local/share/udunits/udunits2.xml"' >> ~/.bashrc && \
# export UDUNITS2_XML_PATH="/usr/local/share/udunits/udunits2.xml"


# https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh