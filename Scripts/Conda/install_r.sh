#!/bin/bash
set -e

conda install --yes -c conda-forge \
	r=$R_BASE_VERSION \
	r-base \
	r-essentials \
	r-irkernel \
	r-devtools \
	r-codetools \
	r-cvtools \
	r-udunits2 \
	r-rstudioapi \
	r-rbokeh \
	r-callr \
	r-stringi \
	r-igraph \
	r-rcurl \
	r-plyr \
    r-tidyverse \
    r-shiny \
    r-rmarkdown \
    r-bookdown \
    r-forecast \
    r-rsqlite \
    r-reshape2 \
    r-nycflights13 \
    r-caret \
    r-crayon \
    r-randomforest \
    r-gplots \
    r-httr \
    r-knitr \
    r-rcolorbrewer \
    r-rjava \
    r-rjson \
    r-r.methodss3 \
    r-r.oo \
    r-stringr \
    r-testthat \
    r-xml \
    r-dt \
    r-htmlwidgets \
    r-diagrammer \
    r-sf \
    r-igraph \
    r-cairo \
	rpy2 \
	rstudio

# cd $CONDA_SRC && git clone --recursive https://github.com/dmlc/xgboost && \
# cd xgboost && sudo make Rbuild && sudo R CMD INSTALL xgboost_*.tar.gz

# cd $CONDA_SRC && wget ftp://ftp.unidata.ucar.edu/pub/udunit s/udunits-2.2.24.tar.gz && \
# tar zxf udunits-2.2.24.tar.gz && cd udunits-2.2.24 && ./configure && make && make install && \
# ldconfig && echo 'export UDUNITS2_XML_PATH="/usr/local/share/udunits/udunits2.xml"' >> ~/.bashrc && \
# export UDUNITS2_XML_PATH="/usr/local/share/udunits/udunits2.xml"

# Rscript /tmp/R/package_installs.R
# Rscript /tmp/R/bioconductor_installs.R
# Rscript /tmp/R/text_analytics.R
# Rscript /tmp/R/install_iR.R

# R -e 'IRkernel::installspec()'

# sudo mv /tmp/R/RProfile.R /usr/local/lib/R/etc/Rprofile.site