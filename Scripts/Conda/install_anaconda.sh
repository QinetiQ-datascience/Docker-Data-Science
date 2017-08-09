#!/bin/bash
set -e

cd /tmp && wget --quiet https://repo.continuum.io/archive/$ANACONDA_VERSION.sh -O /tmp/anaconda.sh
 
bash /tmp/anaconda.sh -f -b -p $CONDA_DIR && rm /tmp/anaconda.sh

conda config --system --add channels conda-forge && \
conda config --system --set auto_update_conda false && \
conda clean -tipsy

conda update --quiet --yes \
    "conda" \
    "anaconda" 

conda update --yes setuptools
pip install --upgrade pip
conda install --yes icu=58 --channel conda-forge

conda create --yes -n sagemath python=2.7 anaconda
bash -c "source activate sagemath && conda install --yes -c conda-forge sagelib && source deactivate sagemath"

conda install --yes -c pstey julia julia-bindeps julia-uriparser julia-compat julia-blosc julia-sha

echo "push!(Libdl.DL_LOAD_PATH, \"$CONDA_DIR/lib\")" >> /opt/conda/etc/julia/juliarc.jl

julia -e 'Pkg.init()' && \
julia -e 'Pkg.update()' && \
julia -e 'Pkg.add("HDF5")' && \
julia -e 'Pkg.add("Gadfly")' && \
julia -e 'Pkg.add("RDatasets")' && \
julia -e 'Pkg.add("Plots")' &&  \
julia -e 'Pkg.add("PyPlot")' &&  \
julia -e 'Pkg.add("IJulia")' && \
julia -e 'using HDF5' && \
julia -e 'using Gadfly' && \
julia -e 'using RDatasets' && \
julia -e 'using Plots' && \
julia -e 'using PyPlot' && \
julia -e 'using IJulia'

# Languages
conda install --yes -c conda-forge \
	nodejs \
	octave \
	perl \
	ruby \
	r-essentials \
	r-xgboost \
	r-irkernel \
	r-devtools \
	r-codetools \
	r-cvtools \
	r-udunits2 \
	r-rstudioapi \
	rpy2 \
	rstudio

conda install --yes -c creditx gcc-7
conda install --yes -c bioconda sbt scala
conda install --yes -c conda-forge cmake autoconf automake boost
conda install --yes -c conda-forge pkg-config


# ensure the right ghc compiler version for Ihaskell, might not be latest
stack upgrade && stack update && stack --resolver ghc-$GHC_VERSION setup --upgrade-cabal --install-ghc && \
stack config set system-ghc --global true && \
cd $IHaskell && stack install gtk2hs-buildtools --install-ghc 

echo $DATASCI_USER | sudo -S chown -R $DATASCI_USER:$DATASCI_USER $CONDA_DIR

pip install bash_kernel && python -m bash_kernel.install --user

npm install -g ijavascript
ijsinstall

pip install octave_kernel && python -m octave_kernel.install --user

$SAGEMATH/bin/python -m pip install ipykernel && $SAGEMATH//bin/python -m ipykernel install --user --name sagemath --display-name "Python 2 (sagemath)"

# Might be bad to blindly update all packages
conda update --all --yes
pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U

# conda install --yes mathjax
conda install --yes --channel damianavila82 rise
# Configure kernels
jupyter-nbextension install rise --py --sys-prefix
jupyter-nbextension enable rise --py --sys-prefix
jupyter-nbextension enable widgetsnbextension --py --sys-prefix
pip install jupyter_dashboards
jupyter dashboards quick-setup --sys-prefix

# cd $CONDA_SRC && wget https://raw.githubusercontent.com/root-project/cling/master/tools/packaging/cpt.py && \
# chmod +x cpt.py && ./cpt.py --check-requirements && ./cpt.py --create-dev-env Debug --with-workdir=./cling-build/ && \
# rm -rf cling-build && rm cpt.py
# jupyter kernelspec install $Cling/cling --user