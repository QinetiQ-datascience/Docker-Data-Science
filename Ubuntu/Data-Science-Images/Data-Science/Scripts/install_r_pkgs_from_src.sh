# XGBoost gets special treatment because the nightlies are hard to build with devtools.
cd $CONDA_SRC && git clone --recursive https://github.com/dmlc/xgboost && \
cd xgboost && make Rbuild && R CMD INSTALL xgboost_*.tar.gz

cd $CONDA_SRC && wget ftp://ftp.unidata.ucar.edu/pub/udunits/udunits-2.2.24.tar.gz && \
tar zxf udunits-2.2.24.tar.gz && cd udunits-2.2.24 && ./configure && make && make install && \
ldconfig && echo 'export UDUNITS2_XML_PATH="/usr/local/share/udunits/udunits2.xml"' >> ~/.bashrc && \
export UDUNITS2_XML_PATH="/usr/local/share/udunits/udunits2.xml"

Rscript /tmp/package_installs.R
$CONDA_BIN/conda install --yes -c r r-tidyverse
$CONDA_BIN/cconda install --yes -c r r-shiny
$CONDA_BIN/conda install --yes -c r r-sparklyr
conda install -c r r-rbokeh