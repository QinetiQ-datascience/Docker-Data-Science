FROM ubuntu:16.04

MAINTAINER Josh Cole <jwcole1@qinetiq.com>

# Configure environment
ENV DEBIAN_FRONTEND=noninteractive
ENV IMAGES_DIR Data-Science-Images
ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH
ENV SHELL /bin/bash
ENV DATASCI_USER datasci
ENV NAME base-data-science
ENV DATASCI_UID 1000
ENV HOME /home/$DATASCI_USER
ENV CONDA_BIN $CONDA_DIR/bin
ENV CONDA_SRC /user/local/src/conda
ENV TINI_VERSION v0.15.0
ENV JULIA_PKGDIR /opt/julia
ENV APACHE_SPARK_VERSION 2.2.0
ENV HADOOP_VERSION 2.7
ENV SPARK_HOME /opt/spark
ENV PYTHONPATH $SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.4-src.zip
ENV MESOS_NATIVE_LIBRARY /usr/local/lib/libmesos.so
ENV SPARK_OPTS --driver-java-options=-Xms1024M --driver-java-options=-Xmx4096M --driver-java-options=-Dlog4j.logLevel=info
ENV SAGE_ROOT /usr/lib/sagemath/
ENV JUPYTER_SHARE /usr/local/share/jupyter
ENV USER_JUPYTER_KERNELS $HOME/.jupyter/kernels
ENV TORRE_VERSION 0.2.0

ADD $IMAGES_DIR/Base-Data-Science/Scripts/setup_datasci_user.sh /tmp/setup_datasci_user.sh
ADD $IMAGES_DIR/Base-Data-Science/Scripts/linux_setup.sh /tmp/linux_setup.sh
ADD $IMAGES_DIR/Base-Data-Science/Scripts/languages_setup.sh /tmp/languages_setup.sh
ADD $IMAGES_DIR/Base-Data-Science/Scripts/install_anaconda.sh /tmp/install_anaconda.sh
ADD $IMAGES_DIR/Base-Data-Science/Scripts/install_jupyter_widgets.sh /tmp/install_jupyter_widgets.sh
ADD $IMAGES_DIR/Base-Data-Science/Scripts/install_conda_r.sh /tmp/install_conda_r.sh
ADD $IMAGES_DIR/Base-Data-Science/Scripts/install_spark.sh /tmp/install_spark.sh
ADD $IMAGES_DIR/Base-Data-Science/Scripts/install_julia_base_pkgs.sh /tmp/install_julia_base_pkgs.sh
ADD $IMAGES_DIR/Base-Data-Science/Scripts/requirements_kernel.txt /tmp/requirements_kernel.txt
ADD $IMAGES_DIR/Scripts/update_conda_pip_pkgs.sh /tmp/update_conda_pip_pkgs.sh
ADD $IMAGES_DIR/Scripts/clean_conda_pip.sh /tmp/clean_conda_pip.sh
ADD $IMAGES_DIR/Base-Data-Science/Scripts/install_sagemath.sh /tmp/install_sagemath.sh
ADD $IMAGES_DIR/Base-Data-Science/Scripts/install_tini.sh /tmp/install_tini.sh
ADD $IMAGES_DIR/Base-Data-Science/Scripts/install_jupyter_kernels.sh /tmp/install_jupyter_kernels.sh
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini.asc /tini.asc


RUN chmod +x /tmp/linux_setup.sh /tmp/languages_setup.sh /tmp/install_anaconda.sh \
	/tmp/install_jupyter_widgets.sh  /tmp/install_conda_r.sh /tmp/install_spark.sh \
	/tmp/install_julia_base_pkgs.sh /tmp/update_conda_pip_pkgs.sh /tmp/clean_conda_pip.sh \
	/tmp/install_sagemath.sh /tmp/install_tini.sh /tmp/install_jupyter_kernels.sh

# Expose Port For Jupyter
EXPOSE 8888 

# The Basics
RUN	apt-get --yes update && apt-get --yes upgrade
RUN apt-get --yes install  aptitude apt-utils sudo locales  

# Locale
RUN sed -i -e 's/# en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_GB.UTF-8  
ENV LANGUAGE en_GB:en  
ENV LC_ALL en_GB.UTF-8

RUN bash /tmp/setup_datasci_user.sh
RUN bash /tmp/linux_setup.sh
RUN bash /tmp/install_sagemath.sh
RUN bash /tmp/install_tini.sh

# Anaconda Setup
USER $DATASCI_USER
RUN bash /tmp/install_anaconda.sh
RUN bash /tmp/install_jupyter_widgets.sh
RUN bash /tmp/update_conda_pip_pkgs.sh

# Additional Langaues
USER root
RUN bash /tmp/languages_setup.sh
RUN bash /tmp/install_spark.sh

USER $DATASCI_USER

RUN bash /tmp/install_conda_r.sh
RUN bash /tmp/install_julia_base_pkgs.sh
RUN bash /tmp/install_jupyter_kernels.sh
# RUN cd $CONDA_SRC/IHaskell && stack install gtk2hs-buildtools && \
#     stack install --fast && \
#     stack exec ihaskell -- install --stack

USER root 
# ~~~~ CLEAN UP ~~~~

RUN apt-get --yes update && apt-get --yes upgrade && apt-get --yes autoremove
RUN apt-get autoremove && apt-get clean \
	&& apt-get purge --auto-remove  -y curl \
	&& rm -rf /var/lib/apt/lists/* \
    && rm -rf /src/*.deb

RUN rm -rf $CONDA_SRC/*

USER $DATASCI_USER
RUN rm -rf $HOME/.local
RUN bash /tmp/clean_conda_pip.sh
COPY $IMAGES_DIR/Base-Data-Science/Scripts/jupyter_notebook_config.py $HOME/.jupyter/
ENTRYPOINT ["/tini", "--"]
CMD ["/bin/bash"]

# Haskel bash