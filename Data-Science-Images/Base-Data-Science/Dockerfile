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
ENV DEBIAN_FRONTEND=noninteractive SHELL=/bin/bash NAME=base-data-science

# The Basics
RUN	apt --yes update && apt --yes upgrade && apt --yes install aptitude apt-utils sudo locales  

# Locale
RUN sed -i -e 's/# en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen

ENV LANG=en_GB.UTF-8 LANGUAGE=en_GB:en  LC_ALL=en_GB.UTF-8

ENV DATASCI_USER=datasci DATASCI_UID=1000 
ENV HOME=/home/$DATASCI_USER
ENV CONDA_DIR=/opt/conda CONDA_SRC=/usr/local/src/conda
ENV CONDA_BIN=$CONDA_DIR/bin 
ENV PATH $CONDA_BIN:$HOME.local/bin:$PATH
RUN echo "cond bin: $CONDA_BIN"
ENV Documents=$HOME/Documents Downloads=$HOME/Downloads Workspace=$HOME/Workspace

ADD Scripts/setup_datasci_user.sh /tmp/setup_datasci_user.sh
RUN bash /tmp/setup_datasci_user.sh

VOLUME ["$Documents", "$Downloads", "$Workspace"]

ADD Scripts/linux_setup.sh /tmp/linux_setup.sh
RUN bash /tmp/linux_setup.sh

ENV SAGE_ROOT=/usr/lib/sagemath/ JUPYTER_SHARE=/usr/local/share/jupyter USER_JUPYTER_KERNELS=$HOME/.jupyter/kernels

ADD Scripts/install_sagemath.sh /tmp/install_sagemath.sh
RUN bash /tmp/install_sagemath.sh

# SHA Currently failing
ENV TINI_VERSION=v0.15.0 TINI_CHECKSUM=595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 TINI_DIR=/opt/tini

ADD Scripts/install_tini.sh /tmp/install_tini.sh
RUN bash /tmp/install_tini.sh

# Anaconda Setup
USER $DATASCI_USER

ADD Scripts/install_anaconda.sh /tmp/install_anaconda.sh
RUN bash /tmp/install_anaconda.sh

# Might be bad to blindly update all packages
ADD Scripts/update_conda_pip_pkgs.sh /tmp/update_conda_pip_pkgs.sh
RUN bash /tmp/update_conda_pip_pkgs.sh

ADD Scripts/install_jupyter_widgets.sh /tmp/install_jupyter_widgets.sh
RUN bash /tmp/install_jupyter_widgets.sh

# Additional Langaues
USER $DATASCI_USER
ADD Scripts/install_conda_r.sh /tmp/install_conda_r.sh
RUN bash /tmp/install_conda_r.sh

USER root

ENV JULIA_PKGDIR=/opt/julia IHaskell=/opt/IHaskell

ADD Scripts/languages_setup.sh /tmp/languages_setup.sh
RUN bash /tmp/languages_setup.sh

USER $DATASCI_USER
ADD Scripts/install_julia_base_pkgs.sh /tmp/install_julia_base_pkgs.sh
RUN bash /tmp/install_julia_base_pkgs.sh

# Don't upgrade sagemath's pip, build breaks. Anaconda's is up to date
ADD Scripts/install_jupyter_kernels.sh /tmp/install_jupyter_kernels.sh
ADD Scripts/requirements_kernel.txt /tmp/requirements_kernel.txt
RUN bash /tmp/install_jupyter_kernels.sh

USER root 

# ~~~~ CLEAN UP ~~~~
RUN apt --yes update && apt --yes upgrade && apt --yes autoremove && apt clean && \
	apt purge --auto-remove  --yes curl && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /src/*.deb && \
    rm -rf $CONDA_SRC/* && \
    rm -rf /tmp/*

RUN chown -R $DATASCI_USER:$DATASCI_USER $HOME

COPY Scripts/jupyter_notebook_config.py /etc/jupyter/
RUN chown -R $DATASCI_USER:$DATASCI_USER /etc/jupyter/

# Expose Port For Jupyter
EXPOSE 8888-9000

USER $DATASCI_USER

RUN rm -rf $HOME/.cache/pip/* && $CONDA_BIN/conda clean -i -l -t --yes

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/bin/bash"]

# Add checksums where possible