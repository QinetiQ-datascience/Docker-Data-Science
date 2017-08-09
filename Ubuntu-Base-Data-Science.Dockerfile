FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04

MAINTAINER Josh Cole <jwcole1@qinetiq.com>

# Configure environment
ENV DEBIAN_FRONTEND=noninteractive SHELL=/bin/bash NAME=ubuntu-base-data-science DATASCI_USER=datasci DATASCI_UID=1000 
ENV HOME=/home/$DATASCI_USER
ENV CONDA_DIR=/opt/conda CONDA_SRC=/usr/local/src/conda
ENV PATH $CONDA_DIR/bin:$HOME/.local/bin:$PATH
ENV IHaskell=/opt/IHaskell Cling=/opt/clingkernel
ENV Documents=$HOME/Documents Downloads=$HOME/Downloads Workspace=$HOME/Workspace

# SHA Currently failing
ENV TINI_VERSION=v0.15.0 TINI_CHECKSUM=595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 TINI_DIR=/opt/tini GOLANG_VERSION=1.8.3
ENV JDK_VERSION=8u144

ADD Scripts/Linux/setup_datasci_user.sh /tmp/setup_datasci_user.sh
RUN bash /tmp/setup_datasci_user.sh

ENV LANG=en_GB.UTF-8 LANGUAGE=en_GB:en  LC_ALL=en_GB.UTF-8

VOLUME ["$Documents", "$Downloads", "$Workspace"]

USER $DATASCI_USER

ENV ANACONDA_VERSION=Anaconda3-4.4.0-Linux-x86_64 GHC_VERSION=8.2.1 SAGEMATH=/opt/conda/envs/sagemath

ADD Scripts/Conda/install_anaconda.sh /tmp/install_anaconda.sh
RUN bash /tmp/install_anaconda.sh

USER root 

# ~~~~ CLEAN UP ~~~~
RUN apt-get update && apt-get --yes upgrade && apt-get --yes autoremove && apt-get clean && \
	rm -rf /var/lib/apt-get/lists/* && \
	rm -rf /src/*.deb && \
    rm -rf $CONDA_SRC/* && \
    rm -rf /tmp/*

COPY Scripts/Jupyter/jupyter_notebook_config.py /etc/jupyter/
RUN chown -R $DATASCI_USER:$DATASCI_USER /etc/jupyter/

# Expose Port For Rstudio and Jupyter
EXPOSE 8787 8888-9000

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 33D40BC6
RUN echo "deb http://rodeo-deb.yhat.com/ rodeo main\n" >> /etc/apt/sources.list
# Rodeo GUI Requirements
RUN apt-get update && apt-get --yes install  libxss1 libgconf-2-4 libnss3 libasound2
RUN add-apt-repository ppa:wireshark-dev/stable
RUN apt-get update && apt-get --yes install rodeo vim gedit nano net-tools netcat wireshark rsync

RUN ln -s /opt/Rodeo/rodeo /usr/bin/

# Rstudio
RUN apt-get update && apt-get --yes install fcitx-frontend-qt5 \
	fcitx-modules \
	fcitx-module-dbus \
	libedit2 \
	libgl1-mesa-dri \
	libgl1-mesa-glx \
	libgstreamer0.10-0 \
	libgstreamer-plugins-base0.10-0 \
	libjpeg-dev \
	libjpeg-turbo8-dev \
	libpresage-dev \
	libpresage-data \
	libqt5core5a \
	libqt5dbus5 \
	libqt5gui5 \
	libqt5network5 \
	libqt5printsupport5 \
	libqt5webkit5 \
	libqt5widgets5 \
	libtiff5 \
	libxcomposite1 \
	libxslt1.1 \
	libxcomposite-dev \
	littler && \
	apt-get clean && \
	rm -rf /var/lib/apt-get/lists/* && \
	rm -rf /src/*.deb && \
    rm -rf $CONDA_SRC/* && \
    rm -rf /tmp/*
RUN chown -R $DATASCI_USER:$DATASCI_USER /opt/Rodeo

# RUN curl -L https://github.com/zeromq/zeromq4-x/archive/v4.0.3.tar.gz > v4.0.3.tar.gz && \
#     tar xvfz v4.0.3.tar.gz && \
#     cd zeromq4-x-4.0.3 && \
#     ./autogen.sh && ./configure && \
#     make && sudo make install && \
#     sudo ldconfig
# ADD conf.d/conda.conf /etc/ld.so.conf.d/


USER $DATASCI_USER
# RUN conda install --yes -c conda-forge libsodium zeromq cairo
USER root
RUN cd /tmp && git clone git://github.com/jedisct1/libsodium.git && cd libsodium && ./autogen.sh && ./configure && make check && make install && ldconfig
RUN cd /tmp && git clone --depth 1 git://github.com/zeromq/libzmq.git && cd libzmq && ./autogen.sh && ./configure && make
# RUN cd /tmp/libzmq && make check
RUN cd /tmp/libzmq && make install && ldconfig
RUN rm /tmp/* -rf
USER $DATASCI_USER
# RUN conda install --yes -c conda-forge stack
RUN stack upgrade && stack update && stack --resolver ghc-$GHC_VERSION setup --upgrade-cabal --install-ghc && \
stack config set system-ghc --global true && \
cd $IHaskell && stack install gtk2hs-buildtools --install-ghc 
RUN cd $IHaskell && stack install --fast && ihaskell install && ihaskell install

RUN rm -rf $HOME/.cache/pip/* && conda clean -i -l -t --yes

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/bin/bash"]
