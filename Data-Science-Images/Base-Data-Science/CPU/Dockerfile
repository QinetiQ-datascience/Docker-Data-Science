FROM ubuntu:16.04

MAINTAINER Josh Cole <jwcole1@qinetiq.com>

# Configure environment
ENV DEBIAN_FRONTEND=noninteractive
ENV IMAGES_DIR Data-Science-Images
ENV CONDA_DIR /opt/conda
ENV JULIA_PKGDIR /opt/julia
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

# Anaconda Setup
USER $DATASCI_USER
RUN bash /tmp/install_anaconda.sh
COPY $IMAGES_DIR/Base-Data-Science/Scripts/jupyter_notebook_config.py $HOME/.jupyter/
RUN bash /tmp/update_conda_pip_pkgs.sh

# Additional Langaues

USER root
# RUN bash /tmp/languages_setup.sh
# apt-get --yes install octave scala
RUN add-apt-repository ppa:staticfloat/juliareleases
RUN  apt-get update && apt-get --yes install julia
RUN  echo "push!(Libdl.DL_LOAD_PATH, \"$CONDA_DIR/lib\")" >> /usr/etc/julia/juliarc.jl && \
    # Create JULIA_PKGDIR \
    mkdir $JULIA_PKGDIR && \
    chown -R $DATASCI_USER:$DATASCI_USER $JULIA_PKGDIR
# RUN	add-apt-repository ppa:staticfloat/julia-deps -y && \
# 	apt-get update -y && \
# 	cd /opt && git clone https://github.com/JuliaLang/julia.git && \
# 	chown -R $DATASCI_USER:$DATASCI_USER $JULIA_PKGDIR

USER $DATASCI_USER
# Install as DataSci User
# RUN bash /tmp/install_conda_r.sh
# RUN $CONDA_BIN/pip install -r /tmp/requirements_kernel.txt --upgrade && $CONDA_BIN/python -m octave_kernel.install

# RUN cd $JULIA_PKGDIR && echo "JULIA_CPU_TARGET=core2" > Make.user && \
# 	make -j 4 julia-deps && make -j 4 && make install

USER root
# RUN ln -s $JULIA_PKGDIR/julia /usr/local/bin/julia
# RUN apt-get --yes install lib32z1 lib32z1-dev gadfly
# USER $DATASCI_USER
# RUN bash /tmp/install_julia_base_pkgs.sh

# USER root

# RUN mkdir -p $HOME/.jupyter/kernels
# RUN chown -R $DATASCI_USER:$DATASCI_USER $HOME/.jupyter/kernels

# # ~~~~ CLEAN UP ~~~~

# RUN apt-get --yes update && apt-get --yes upgrade && apt-get --yes autoremove
# RUN apt-get autoremove && apt-get clean \
# 	&& apt-get purge --auto-remove  -y curl \
# 	&& rm -rf /var/lib/apt/lists/* \
#     && rm -rf /src/*.deb

# RUN rm -rf $CONDA_SRC/*

USER $DATASCI_USER
    # Show Julia where conda libraries are \
# RUN	echo "push!(Libdl.DL_LOAD_PATH, \"$CONDA_DIR/lib\")" > $HOME/.juliarc.jl

# RUN julia -e 'Pkg.init()' && \
#     julia -e 'Pkg.update()'

# RUN julia -e 'Pkg.add("HDF5")' && \
#     julia -e 'Base.compilecache("HDF5")'

# RUN	$JULIA_PKGDIR/julia -e 'Pkg.add("Gadfly")' && \
# 	$JULIA_PKGDIR/julia -e 'Pkg.build("Gadfly")' && \
# 	$JULIA_PKGDIR/julia -e 'Base.compilecache("Gadfly")'

# RUN $JULIA_PKGDIR/julia -e 'Pkg.add("RDatasets")' && \
#     $JULIA_PKGDIR/julia -e 'Base.compilecache("RDatasets")'

# RUN $JULIA_PKGDIR/julia -e 'Pkg.add("IJulia")' && \
# 	$JULIA_PKGDIR/julia -e 'Pkg.build("IJulia")' && \
# 	$JULIA_PKGDIR/julia -e 'Base.compilecache("IJulia")'
#     # Precompile Julia packages \

# RUN $JULIA_PKGDIR/julia -e 'using HDF5' && \
#     $JULIA_PKGDIR/julia -e 'using Gadfly' && \
#     $JULIA_PKGDIR/julia -e 'using RDatasets' && \
#     $JULIA_PKGDIR/julia -e 'using IJulia' 

#     # move kernelspec out of home \
# RUN mv $HOME/.local/share/jupyter/kernels/julia* $CONDA_DIR/share/jupyter/kernels/ && \
#     chmod -R go+rx $CONDA_DIR/share/jupyter && \
#     rm -rf $HOME/.local
RUN julia -e 'Pkg.init()' && \
    julia -e 'Pkg.update()' && \
    julia -e 'Pkg.add("HDF5")' && \
    julia -e 'Pkg.add("Gadfly")' && \
    julia -e 'Pkg.add("RDatasets")' && \
    julia -e 'Pkg.add("IJulia")' && \
    # Precompile Julia packages \
    julia -e 'using HDF5' && \
    julia -e 'using Gadfly' && \
    julia -e 'using RDatasets' && \
    julia -e 'using IJulia'
    # move kernelspec out of home \
RUN cp -r $HOME/.local/share/jupyter/kernels/julia* $CONDA_DIR/share/jupyter/kernels/ && \
    chmod -R go+rx $CONDA_DIR/share/jupyter
RUN bash /tmp/clean_conda_pip.sh

CMD ["/bin/bash"]

# --no-install-recommends
##
##    texlive-latex-base \
    # texlive-latex-extra \
    # texlive-fonts-extra \
    # texlive-fonts-recommended \
    # texlive-generic-recommended \
# unzip libsm6 jed emacs libxrender1
# 
# 
# ENV TINI_VERSION v0.15.0
# ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
# ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini.asc /tini.asc
# RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 \
#  && gpg --verify /tini.asc
# RUN    mv tini /usr/local/bin/tini && \
    # chmod +x /usr/local/bin/tini
# ENTRYPOINT ["/tini", "--"]