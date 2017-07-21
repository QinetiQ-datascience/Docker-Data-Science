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

ADD $IMAGES_DIR/Base-Data-Science/Scripts/linux_setup.sh /tmp/linux_setup.sh
ADD $IMAGES_DIR/Base-Data-Science/Scripts/languages_setup.sh /tmp/languages_setup.sh
ADD $IMAGES_DIR/Base-Data-Science/Scripts/install_anaconda.sh /tmp/install_anaconda.sh
ADD $IMAGES_DIR/Base-Data-Science/Scripts/install_conda_r.sh /tmp/install_conda_r.sh
ADD $IMAGES_DIR/Base-Data-Science/Scripts/install_julia_base_pkgs.sh /tmp/install_julia_base_pkgs.sh
ADD $IMAGES_DIR/Base-Data-Science/Scripts/requirements_kernel.txt /tmp/requirements_kernel.txt
ADD $IMAGES_DIR/Scripts/update_conda_pip_pkgs.sh /tmp/update_conda_pip_pkgs.sh
ADD $IMAGES_DIR/Scripts/clean_conda_pip.sh /tmp/clean_conda_pip.sh

RUN chmod +x /tmp/linux_setup.sh /tmp/languages_setup.sh /tmp/install_anaconda.sh /tmp/install_conda_r.sh /tmp/install_julia_base_pkgs.sh

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

RUN useradd -m --shell /bin/bash --uid $DATASCI_UID --user-group $DATASCI_USER 

VOLUME ["$HOME/Workspace", "$HOME/Downloads"]

RUN mkdir -p $CONDA_DIR && chown $DATASCI_USER $CONDA_DIR

# Change ownership
RUN chown -R $DATASCI_USER:$DATASCI_USER $CONDA_DIR

# Users passwords
RUN echo "$DATASCI_USER:$DATASCI_USER"|chpasswd && adduser $DATASCI_USER sudo
RUN echo "root:Docker!" | chpasswd

RUN bash /tmp/linux_setup.sh
# RUN mkdir -p $CONDA_SRC 
# RUN chown -R $DATASCI_USER:$DATASCI_USER $CONDA_SRC

# Anaconda Setup
USER $DATASCI_USER
RUN bash /tmp/install_anaconda.sh
COPY $IMAGES_DIR/Base-Data-Science/Scripts/jupyter_notebook_config.py $HOME/.jupyter/
RUN bash /tmp/update_conda_pip_pkgs.sh

# Additional Langaues

USER root

ENV TINI_VERSION v0.15.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini.asc /tini.asc
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 \
 && gpg --verify /tini.asc
RUN    mv tini /usr/local/bin/tini && \
    chmod +x /usr/local/bin/tini

ENV STACK /usr/local/bin/stack
RUN mkdir -p $CONDA_SRC && chown -R $DATASCI_USER:$DATASCI_USER $CONDA_SRC
RUN apt-get update && apt-get --yes install libtinfo-dev libcairo2-dev libpango1.0-dev libmagic-dev libblas-dev liblapack-dev



# RUN apt-get update && apt-get --yes install octave scala
# RUN apt-get update && apt-get --yes install libzmq-dev
# ENV JULIA_PKGDIR /opt/julia

# RUN echo "deb http://ppa.launchpad.net/staticfloat/juliareleases/ubuntu trusty main" > /etc/apt/sources.list.d/julia.list && \
#     apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3D3D3ACC && \
#     apt-get update && \
#     apt-get install -y --no-install-recommends \
#     julia && apt-get clean && \
#     rm -rf /var/lib/apt/lists/* && \
#     # Show Julia where conda libraries are \
#     echo "push!(Libdl.DL_LOAD_PATH, \"$CONDA_DIR/lib\")" >> /usr/etc/julia/juliarc.jl && \
#     # Create JULIA_PKGDIR \
#     mkdir $JULIA_PKGDIR && \
#     chown -R $DATASCI_USER:$DATASCI_USER $JULIA_PKGDIR


# ENV APACHE_SPARK_VERSION 2.2.0
# ENV HADOOP_VERSION 2.7
# ENV SPARK_HOME /opt/spark
# ENV PYTHONPATH $SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.4-src.zip
# ENV MESOS_NATIVE_LIBRARY /usr/local/lib/libmesos.so
# ENV SPARK_OPTS --driver-java-options=-Xms1024M --driver-java-options=-Xmx4096M --driver-java-options=-Dlog4j.logLevel=info



# RUN cd /tmp && \
#         wget -q http://d3kbcqa49mib13.cloudfront.net/spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
#         echo "7a186a2a007b2dfd880571f7214a7d329c972510a460a8bdbef9f7f2a891019343c020f74b496a61e5aa42bc9e9a79cc99defe5cb3bf8b6f49c07e01b259bc6b *spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" | sha512sum -c - && \
#         tar xzf spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz -C /opt  && \
#         rm spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz
# RUN cd /opt && ln -s spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} spark
# RUN chown -R $DATASCI_USER:$DATASCI_USER $SPARK_HOME

# # Mesos dependencies
# RUN apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF && \
#     DISTRO=debian && \
#     CODENAME=jessie && \
#     echo "deb http://repos.mesosphere.io/${DISTRO} ${CODENAME} main" > /etc/apt/sources.list.d/mesosphere.list && \
#     apt-get -y update && \
#     apt-get --no-install-recommends -y --force-yes install mesos=1.2\* && \
#     apt-get clean && \
#     rm -rf /var/lib/apt/lists/*
RUN apt-get --yes install git
USER $DATASCI_USER
RUN cd $CONDA_SRC && git clone https://github.com/gibiansky/IHaskell && \
    $CONDA_BIN/conda install --yes -c asmeurer haskell-platform
# RUN bash /tmp/install_conda_r.sh
# RUN $CONDA_BIN/pip install -r /tmp/requirements_kernel.txt && $CONDA_BIN/python -m octave_kernel.install
# RUN cd $CONDA_SRC/IHaskell && stack install gtk2hs-buildtools && \
#     stack install --fast && \
#     stack exec ihaskell -- install --stack



USER root
RUN apt-add-repository -y ppa:aims/sagemath && apt-get update && apt-get --yes install sagemath-upstream-binary

# # RUN ln -s $JULIA_PKGDIR/julia /usr/local/bin/julia
# USER $DATASCI_USER
# # RUN bash /tmp/install_julia_base_pkgs.sh

# USER root

# RUN mkdir -p $HOME/.jupyter/kernels
RUN chown -R $DATASCI_USER:$DATASCI_USER /usr/lib/sagemath
RUN mkdir -p /usr/local/share/jupyter && chown -R $DATASCI_USER:$DATASCI_USER /usr/local/share/jupyter
RUN chown -R $DATASCI_USER:$DATASCI_USER /usr/local/share/jupyter
# RUN chown -R $DATASCI_USER:$DATASCI_USER $HOME/.jupyter/kernels

# # ~~~~ CLEAN UP ~~~~

# RUN apt-get --yes update && apt-get --yes upgrade && apt-get --yes autoremove
# RUN apt-get autoremove && apt-get clean \
# 	&& apt-get purge --auto-remove  -y curl \
# 	&& rm -rf /var/lib/apt/lists/* \
#     && rm -rf /src/*.deb

# RUN rm -rf $CONDA_SRC/*

# USER $DATASCI_USER

# # Add Julia packages

# RUN julia -e 'Pkg.init()' && \
#     julia -e 'Pkg.update()' && \
#     julia -e 'Pkg.add("HDF5")' && \
#     julia -e 'Pkg.add("Gadfly")' && \
#     julia -e 'Pkg.add("RDatasets")' && \
#     julia -e 'Pkg.add("IJulia")' && \
#     # Precompile Julia packages \
#     julia -e 'using HDF5' && \
#     julia -e 'using Gadfly' && \
#     julia -e 'using RDatasets' && \
#     julia -e 'using IJulia'
#     # move kernelspec out of home \
# RUN mv $HOME/.local/share/jupyter/kernels/octave* $CONDA_DIR/share/jupyter/kernels/
# RUN mv $HOME/.local/share/jupyter/kernels/julia* $CONDA_DIR/share/jupyter/kernels/ && \
#     chmod -R go+rx $CONDA_DIR/share/jupyter

# USER $DATASCI_USER
# ENV TORRE_VERSION 0.2.0
# RUN pip install https://dist.apache.org/repos/dist/dev/incubator/toree/${TORRE_VERSION}/snapshots/dev1/toree-pip/toree-${TORRE_VERSION}.dev1.tar.gz
# RUN echo "$(ls -la $SPARK_HOME)"
# RUN jupyter toree install --user --spark_home=$SPARK_HOME --interpreters=PySpark,SQL,Scala,R
# RUN $CONDA_BIN/conda install -c conda-forge spylon-kernel && $CONDA_BIN/python -m spylon_kernel install
# RUN $CONDA_BIN/pip install bash_kernel && $CONDA_BIN/python -m bash_kernel.install
#    # rm -rf $HOME/.local
# RUN bash /tmp/clean_conda_pip.sh
ENV SAGE_ROOT /usr/lib/sagemath/
RUN mkdir -p $HOME/.sage
RUN chown -R $DATASCI_USER:$DATASCI_USER $HOME/.sage && chmod -R 775 $HOME/.sage
USER $DATASCI_USER
RUN $CONDA_BIN/jupyter kernelspec install /usr/lib/sagemath/local/share/jupyter/kernels/sagemath
RUN /usr/lib/sagemath/local/bin/python2.7 -m pip install ipykernel
RUN /usr/lib/sagemath/local/bin/python2.7 -m ipykernel install --user
# RUN cp -r /usr/lib/sagemath/local/share/jupyter/kernels/ $CONDA_DIR/share/jupyter/kernels/
# ENTRYPOINT ["/tini", "--"]
CMD ["/bin/bash"]

# Haskel bash
# 
# /usr/lib/sagemath/local/lib/python2.7