FROM ubuntu:16.04

MAINTAINER Josh Cole <jwcole1@qinetiq.com>

# Configure environment
ENV DEBIAN_FRONTEND=noninteractive
ENV IMAGES_DIR Data-Science-Images

ENV SHELL /bin/bash
ENV NAME base-data-science

# The Basics
RUN	apt-get --yes update && apt-get --yes upgrade
RUN apt-get --yes install  aptitude apt-utils sudo locales  

# Locale
RUN sed -i -e 's/# en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_GB.UTF-8  
ENV LANGUAGE en_GB:en  
ENV LC_ALL en_GB.UTF-8

ENV DATASCI_USER datasci
ENV DATASCI_UID 1000
ENV HOME /home/$DATASCI_USER

ENV CONDA_DIR /opt/conda
ENV CONDA_BIN $CONDA_DIR/bin
ENV PATH $CONDA_BIN:$PATH
ENV CONDA_SRC /user/local/src/conda

ADD $IMAGES_DIR/Base-Data-Science/Scripts/setup_datasci_user.sh /tmp/setup_datasci_user.sh
RUN bash /tmp/setup_datasci_user.sh

ADD $IMAGES_DIR/Base-Data-Science/Scripts/linux_setup.sh /tmp/linux_setup.sh
RUN bash /tmp/linux_setup.sh

ENV SAGE_ROOT /usr/lib/sagemath/
ENV JUPYTER_SHARE /usr/local/share/jupyter
ENV USER_JUPYTER_KERNELS $HOME/.jupyter/kernels

ADD $IMAGES_DIR/Base-Data-Science/Scripts/install_sagemath.sh /tmp/install_sagemath.sh
RUN bash /tmp/install_sagemath.sh

ENV TINI_VERSION v0.15.0
ENV TINI_CHECKSUM 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7
ENV TINI_DIR /opt/tini

ADD $IMAGES_DIR/Base-Data-Science/Scripts/install_tini.sh /tmp/install_tini.sh
RUN bash /tmp/install_tini.sh

# Anaconda Setup
USER $DATASCI_USER

ADD $IMAGES_DIR/Base-Data-Science/Scripts/install_anaconda.sh /tmp/install_anaconda.sh
RUN bash /tmp/install_anaconda.sh

ADD $IMAGES_DIR/Base-Data-Science/Scripts/install_jupyter_widgets.sh /tmp/install_jupyter_widgets.sh
RUN bash /tmp/install_jupyter_widgets.sh

# ADD $IMAGES_DIR/Scripts/update_conda_pip_pkgs.sh /tmp/update_conda_pip_pkgs.sh
# RUN bash /tmp/update_conda_pip_pkgs.sh

ENV JULIA_PKGDIR /opt/julia
# # Additional Langaues
# USER root

# ADD $IMAGES_DIR/Base-Data-Science/Scripts/languages_setup.sh /tmp/languages_setup.sh
# RUN bash /tmp/languages_setup.sh
ENV APACHE_SPARK_VERSION 2.2.0
ENV HADOOP_VERSION 2.7
ENV SPARK_HADOOP_CHECKSUM 7a186a2a007b2dfd880571f7214a7d329c972510a460a8bdbef9f7f2a891019343c020f74b496a61e5aa42bc9e9a79cc99defe5cb3bf8b6f49c07e01b259bc6b
ENV SPARK_HOME /opt/spark
ENV PYTHONPATH $SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.4-src.zip
ENV MESOS_NATIVE_LIBRARY /usr/local/lib/libmesos.so
ENV SPARK_OPTS --driver-java-options=-Xms1024M --driver-java-options=-Xmx4096M --driver-java-options=-Dlog4j.logLevel=info
# ADD $IMAGES_DIR/Base-Data-Science/Scripts/install_spark.sh /tmp/install_spark.sh
# RUN bash /tmp/install_spark.sh

# RUN add-apt-repository ppa:chronitis/jupyter
# RUN apt-get --yes update && apt-get install ihaskell ijulia ijavascript

# USER $DATASCI_USER
# ADD $IMAGES_DIR/Base-Data-Science/Scripts/install_conda_r.sh /tmp/install_conda_r.sh
# RUN bash /tmp/install_conda_r.sh

# ADD $IMAGES_DIR/Base-Data-Science/Scripts/install_julia_base_pkgs.sh /tmp/install_julia_base_pkgs.sh
# RUN bash /tmp/install_julia_base_pkgs.sh
ENV TORRE_VERSION 0.2.0
# ADD $IMAGES_DIR/Base-Data-Science/Scripts/install_jupyter_kernels.sh /tmp/install_jupyter_kernels.sh
# ADD $IMAGES_DIR/Base-Data-Science/Scripts/requirements_kernel.txt /tmp/requirements_kernel.txt
# RUN bash /tmp/install_jupyter_kernels.sh
# # RUN cd $CONDA_SRC/IHaskell && stack install gtk2hs-buildtools && \
# #     stack install --fast && \
# #     stack exec ihaskell -- install --stack

USER root 
# ~~~~ CLEAN UP ~~~~


RUN apt-get --yes update && apt-get --yes upgrade && apt-get --yes autoremove&& apt-get clean \
	&& apt-get purge --auto-remove  -y curl \
	&& rm -rf /var/lib/apt/lists/* \
    && rm -rf /src/*.deb \
    && rm -rf $CONDA_SRC/*

# Expose Port For Jupyter
EXPOSE 8888-9000

USER $DATASCI_USER

RUN rm -rf $HOME/.local
ADD $IMAGES_DIR/Scripts/clean_conda_pip.sh /tmp/clean_conda_pip.sh
RUN bash /tmp/clean_conda_pip.sh

COPY $IMAGES_DIR/Base-Data-Science/Scripts/jupyter_notebook_config.py $HOME/.jupyter/

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/bin/bash"]

# look at specifying where kernels are installed to
# Add checksums where possible