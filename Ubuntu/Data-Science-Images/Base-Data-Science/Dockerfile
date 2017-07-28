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
ENV PATH $CONDA_BIN:$HOME.local/bin:$PATH
ENV Documents=$HOME/Documents Downloads=$HOME/Downloads Workspace=$HOME/Workspace

ADD Scripts/Linux_Config/setup_datasci_user.sh /tmp/setup_datasci_user.sh
RUN bash /tmp/setup_datasci_user.sh

VOLUME ["$Documents", "$Downloads", "$Workspace"]

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
# SHA Currently failing
ENV TINI_VERSION=v0.15.0 TINI_CHECKSUM=595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 TINI_DIR=/opt/tini

ADD Scripts/Linux_Config/linux_configuration.sh /tmp/linux_configuration.sh
ADD Scripts/Languages/Java/install_java.sh /tmp/install_java.sh
RUN bash /tmp/linux_configuration.sh

# Additional Languages

USER $DATASCI_USER
ENV ANACONDA_VERSION=Anaconda3-4.4.0-Linux-x86_64

ADD Scripts/Languages/Python/install_anaconda.sh /tmp/install_anaconda.sh
RUN bash /tmp/install_anaconda.sh

# # Might be bad to blindly update all packages
# ADD Scripts/Languages/Python/update_conda_pip_pkgs.sh /tmp/update_conda_pip_pkgs.sh
# RUN bash /tmp/update_conda_pip_pkgs.sh

# ADD Scripts/Jupyter/install_jupyter_widgets.sh /tmp/install_jupyter_widgets.sh
# RUN bash /tmp/install_jupyter_widgets.sh

# ADD Scripts/Languages/R/install_conda_r.sh /tmp/install_conda_r.sh
# RUN bash /tmp/install_conda_r.sh

# USER root
ENV SCALA_VERSION=2.12.2 ENV SBT_VERSION=0.13.15 SCALA_HOME=/usr/local/share/scala
ENV PATH $SCALA_HOME/bin:$PATH
# ENV SAGE_ROOT=/usr/lib/sagemath/ JUPYTER_SHARE=/usr/local/share/jupyter USER_JUPYTER_KERNELS=$HOME/.jupyter/kernels

# ADD Scripts/SageMath/install_sagemath.sh /tmp/install_sagemath.sh
# RUN bash /tmp/install_sagemath.sh

# ENV JULIA_PKGDIR=/opt/julia IHaskell=/opt/IHaskell OCTAVE_VERSION=octave-4.2.1

# ADD Scripts/Languages/Javascript/install_javascript.sh /tmp/install_javascript.sh
# RUN bash /tmp/install_javascript.sh

# USER $DATASCI_USER
# ADD Scripts/install_julia_base_pkgs.sh /tmp/install_julia_base_pkgs.sh
# RUN bash /tmp/install_julia_base_pkgs.sh

# # Don't upgrade sagemath's pip, build breaks. Anaconda's is up to date
# ADD Scripts/install_jupyter_kernels.sh /tmp/install_jupyter_kernels.sh
# ADD Scripts/requirements_kernel.txt /tmp/requirements_kernel.txt
# RUN bash /tmp/install_jupyter_kernels.sh

USER root 

# ~~~~ CLEAN UP ~~~~
RUN apt-get update && apt-get --yes upgrade && apt-get --yes autoremove && apt-get clean && \
	apt-get purge --auto-remove  --yes curl && \
	rm -rf /var/lib/apt-get/lists/* && \
	rm -rf /src/*.deb && \
    rm -rf $CONDA_SRC/* && \
    rm -rf /tmp/*

RUN chown -R $DATASCI_USER:$DATASCI_USER $HOME

COPY Scripts/jupyter_notebook_config.py /etc/jupyter/
RUN chown -R $DATASCI_USER:$DATASCI_USER /etc/jupyter/

# Expose Port For Jupyter
EXPOSE 8888-9000

USER $DATASCI_USER

RUN mv $HOME/.local/share/jupyter/kernels/* $CONDA_DIR/share/jupyter/kernels/
RUN rm -rf $HOME/.cache/pip/* && $CONDA_BIN/conda clean -i -l -t --yes

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/bin/bash"]

# Add checksums where possible
# Edit /etc/docker/daemon.json. If it does not yet exist, create it. Assuming that the file was empty, add the following contents.

# {
#   "storage-driver": "overlay2"
# }
# 
# sudo apt-get update && sudo apt-get install --yes \
# libblas-dev \
# liblapack-dev \
# libatlas-base-dev \
# libxss1 \
# libgconf-2-4 \
# libnss3 \
# libasound2 	\
# hicolor-icon-theme \
# fcitx-frontend-qt5 \
# fcitx-modules \
# fcitx-module-dbus \
# libedit2 \
# libgl1-mesa-dri \
# libgl1-mesa-glx \
# libgstreamer0.10-0 \
# libgstreamer-plugins-base0.10-0 \
# libjpeg-dev \
# libpresage-data \
# libqt5core5a \
# libqt5dbus5 \
# libqt5gui5 \
# libqt5network5 \
# libqt5printsupport5 \
# libqt5webkit5 \
# libqt5widgets5 \
# libtiff5 \
# libxcomposite1 \
# libxslt1.1 \
# littler 
# 
# 	rm -rf /var/lib/apt/lists/* && \
	# rm -rf /var/cache/oracle-jdk8-installer;
# 
# add apt-get clean all