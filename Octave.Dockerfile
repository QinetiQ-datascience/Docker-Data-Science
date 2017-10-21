FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04

MAINTAINER Josh Cole <jwcole1@qinetiq.com>

# ENV http_proxy "http://wwwproxy.qinetiq.com:80"
# ENV https_proxy "http://wwwproxy.qinetiq.com:80"

# Configure environment
ENV DEBIAN_FRONTEND=noninteractive SHELL=/bin/bash NAME=ubuntu-base-data-science DATASCI_USER=datasci DATASCI_UID=1000
ENV HOME=/home/$DATASCI_USER
ENV CONDA_DIR=/opt/conda CONDA_SRC=/usr/local/src/conda
ENV PATH $CONDA_DIR/bin:$HOME/.local/bin:$PATH
ENV Documents=$HOME/Documents Downloads=$HOME/Downloads Workspace=$HOME/Workspace

# SHA Currently failing
ENV TINI_VERSION=v0.15.0 TINI_CHECKSUM=595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 TINI_DIR=/opt/tini
ENV JDK_VERSION=8u144

RUN apt-get update && apt-get --yes upgrade && apt-get --yes --no-install-recommends install aptitude apt-utils sudo locales && \
apt-get clean all && rm -rf /var/lib/apt/lists/*
# Locale
RUN sed -i -e 's/# en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB:en
ENV LC_ALL en_GB.UTF-8

COPY Scripts/Linux/setup_datasci_user.sh /tmp/
RUN bash /tmp/setup_datasci_user.sh

VOLUME ["$Documents", "$Downloads", "$Workspace"]

ENV Jupyter_Share=/usr/local/share/jupyter
RUN mkdir -p $Jupyter_Share && chown -R $DATASCI_USER:$DATASCI_USER $Jupyter_Share
RUN mkdir -p /etc/jupyter && chown -R $DATASCI_USER:$DATASCI_USER /etc/jupyter/

RUN cd /opt/ && wget https://download-cf.jetbrains.com/python/pycharm-community-2017.2.1.tar.gz && tar -xzf pycharm-community-2017.2.1.tar.gz
RUN rm /opt/pycharm-community-2017.2.1.tar.gz
RUN chown -R $DATASCI_USER:$DATASCI_USER /opt/pycharm-community-2017.2.1

USER $DATASCI_USER

ENV PYTHON_VERSION=3 ANACONDA_VERSION=5.0.0.1 LINUX_VERSION=x86_64
ENV ANACONDA=Anaconda$PYTHON_VERSION-$ANACONDA_VERSION-Linux-$LINUX_VERSION.sh

COPY Scripts/Conda/install_anaconda.sh /tmp/
RUN bash /tmp/install_anaconda.sh
COPY Scripts/Conda/install_conda_base.sh /tmp/
RUN bash /tmp/install_conda_base.sh
USER root

RUN apt-get update && apt-get upgrade --yes && apt-get install --yes libedit-dev libbsd-dev libncurses-dev libreadline6 libreadline-dev libreadline6-dev libtinfo-dev texinfo

USER $DATASCI_USER
ENV OCTAVE_VERSION=4.2.1
COPY Scripts/Conda/install_octave.sh /tmp/

RUN bash /tmp/install_octave.sh

RUN cd /tmp &&  wget https://downloads.sourceforge.net/octave/control-3.0.0.tar.gz \
    && wget https://downloads.sourceforge.net/octave/signal-1.3.2.tar.gz \
    && wget https://downloads.sourceforge.net/octave/statistics-1.3.0.tar.gz \
    && wget https://downloads.sourceforge.net/octave/io-2.4.7.tar.gz
USER root
RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt-get update && apt-get install --yes  build-essential
RUN apt-get update && apt-get install --yes libstdc++6 libstdc++-6-dev libblas-dev libgfortran3 libc6 libc6-dev libgcc1  gcc-7 g++-7 libgcc-7-dev libstdc++-7-dev gfortran-7
RUN rm $CONDA_DIR/lib/libtinfo.so.5
RUN apt-get update && apt-get install --yes gcc-5 libgcc-5-dev libstdc++-5-dev gfortran-5 gcc-6 libgcc-6-dev libstdc++-6-dev gfortran-6

<<<<<<< HEAD
RUN ldconfig
USER $DATASCI_USER
RUN mkdir /home/datasci/octave
RUN cd /tmp && octave --eval 'pkg update'
RUN cd /tmp && octave --eval "cd /home/datasci/octave; \
                              more off; \
                              pkg install -global -forge -verbose control"

RUN octave --eval "cd /home/datasci/octave; \
                    more off; \
                    pkg install -global -forge -verbose general signal image io statistics"

COPY Scripts/Octave/qt-settings $HOME/.config/octave/
RUN sudo chown datasci:datasci $HOME/.config/octave/qt-settings
# RUN apt-get update && apt-get install --yes graphviz
# RUN wget http://sourceforge.net/projects/octave/files/Octave%20Forge%20Packages/Individual%20Package%20Releases/control-2.8.0.tar.gz -P /home/datasci/octave
# RUN wget http://sourceforge.net/projects/octave/files/Octave%20Forge%20Packages/Individual%20Package%20Releases/general-1.3.4.tar.gz -P /home/datasci/octave
# RUN wget http://sourceforge.net/projects/octave/files/Octave%20Forge%20Packages/Individual%20Package%20Releases/signal-1.3.0.tar.gz -P /home/datasci/octave
# RUN wget http://sourceforge.net/projects/octave/files/Octave%20Forge%20Packages/Individual%20Package%20Releases/image-2.2.2.tar.gz -P /home/datasci/octave
# RUN wget http://sourceforge.net/projects/octave/files/Octave%20Forge%20Packages/Individual%20Package%20Releases/io-2.0.2.tar.gz -P /home/datasci/octave
# RUN wget http://sourceforge.net/projects/octave/files/Octave%20Forge%20Packages/Individual%20Package%20Releases/statistics-1.2.4.tar.gz -P /home/datasci/octave
#
# # Install Octave forge packages
# RUN octave --eval "cd /home/datasci/octave; \
#                    more off; \
#                    pkg install -auto -global -verbose \
#                    control-2.8.0.tar.gz \
#                    general-1.3.4.tar.gz \
#                    signal-1.3.0.tar.gz \
#                    image-2.2.2.tar.gz \
#                    io-2.0.2.tar.gz \
#                    statistics-1.2.4.tar.gz"

# RUN cd /tmp && octave --eval "pkg install control-3.0.0.tar.gz" \
#     && octave --eval "pkg install signal-1.3.2.tar.gz" \
#     && octave --eval "pkg install io-2.4.7.tar.gz"
#
# ADD Scripts/Jupyter/jupyter_notebook_config.py /etc/jupyter/
# RUN conda update --all --yes
# # USER root
# # ADD Scripts/conf/conda.conf /etc/ld.so.conf.d/
# # RUN ldconfig
# # ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/conda/lib/
# # ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/conda/lib/:/opt/conda/lib64/:/opt/conda/x86_64-conda_cos6-linux-gnu/sysroot/lib:/opt/conda/x86_64-conda_cos6-linux-gnu/sysroot/usr/lib64/
# USER $DATASCI_USER
# RUN conda clean --yes --all
# ENV R_BASE_VERSION=3.4.1
# ADD Scripts/Conda/install_r.sh /tmp/
# RUN bash /tmp/install_r.sh
# RUN echo 'options(unzip="internal", repos = c(CRAN = "https://www.stats.bris.ac.uk/R/"), download.file.method = "libcurl")' >> $CONDA_DIR/lib/R/etc/Rprofile.site
# ENV LANG en_US.UTF-8
# ENV LANGUAGE en_US:en
# ENV LC_ALL en_US.UTF-8
# ADD Scripts/R /tmp/R
# RUN Rscript /tmp/R/package_installs.R
# RUN Rscript /tmp/R/bioconductor_installs.R
# RUN Rscript /tmp/R/text_analytics.R
# RUN Rscript /tmp/R/install_iR.R

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/bin/bash"]

# xorg-libxau xorg-libxdmcp xorg-libx11 xorg-xproto xorg-libxext xorg-kbproto xorg-libice \
# xorg-libsm xorg-xextproto xorg-libxrender xorg-libxt xorg-libxtst xorg-libxcb xorg-xcb-proto xorg-libxfixes xorg-libxi \
# xorg-util-macros xorg-makedepend xorg-imake xorg-font-util xorg-gccmakedep
# mesa-libgl-cos6-x86_64 libxdamage-cos6-x86_64 libxxf86vm-cos6-x86_64 mesa mesalib \
