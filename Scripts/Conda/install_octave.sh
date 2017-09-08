#!/bin/bash
set -e

conda install --yes -c conda-forge \
	readline \
	octave 

pip install octave_kernel && python -m octave_kernel.install

mv $HOME/.local/share/jupyter/kernels/octave $CONDA_DIR/share/jupyter/kernels

cd /tmp &&  wget https://downloads.sourceforge.net/octave/control-3.0.0.tar.gz &&  wget https://downloads.sourceforge.net/octave/signal-1.3.2.tar.gz && wget https://downloads.sourceforge.net/octave/statistics-1.3.0.tar.gz
wget https://downloads.sourceforge.net/octave/io-2.4.7.tar.gz
octave --eval "pkg install control-3.0.0.tar.gz"
octave --eval "pkg install signal-1.3.2.tar.gz"
octave --eval "pkg install io-2.4.7.tar.gz"
apt-get update && apt-get -y install gfortran wget cpio && \
  cd /tmp && \
  wget http://registrationcenter-download.intel.com/akdlm/irc_nas/tec/11544/l_mkl_2017.3.196.tgz && \
  tar -xzvf l_mkl_2017.3.196.tgz && \
  cd l_mkl_2017.3.196 && \
  sed -i 's/ACCEPT_EULA=decline/ACCEPT_EULA=accept/g' silent.cfg && \
  sed -i 's/ARCH_SELECTED=ALL/ARCH_SELECTED=INTEL64/g' silent.cfg && \
#  sed -i 's/COMPONENTS=DEFAULTS/COMPONENTS=;intel-comp-l-all-vars__noarch;intel-openmp-l-all__x86_64;intel-openmp-l-ps-libs__x86_64;intel-openmp-l-ps-libs-jp__x86_64;intel-tbb-libs__noarch;intel-mkl-common__noarch;intel-mkl-sta-common__noarch;intel-mkl__x86_64;intel-mkl-rt__x86_64;intel-mkl-ps-rt-jp__x86_64;intel-mkl-doc__noarch;intel-mkl-ps-doc__noarch;intel-mkl-ps-doc-jp__noarch;intel-mkl-gnu__x86_64;intel-mkl-gnu-rt__x86_64;intel-mkl-ps-common__noarch;intel-mkl-ps-common-jp__noarch;intel-mkl-ps-common-64bit__x86_64;intel-mkl-common-c__noarch;intel-mkl-common-c-64bit__x86_64;intel-mkl-ps-common-c__noarch;intel-mkl-doc-c__noarch;intel-mkl-ps-doc-c-jp__noarch;intel-mkl-ps-ss-tbb__x86_64;intel-mkl-ps-ss-tbb-rt__x86_64;intel-mkl-gnu-c__x86_64;intel-mkl-ps-common-f__noarch;intel-mkl-ps-common-f-64bit__x86_64;intel-mkl-ps-doc-f__noarch;intel-mkl-ps-doc-f-jp__noarch;intel-mkl-ps-gnu-f-rt__x86_64;intel-mkl-ps-gnu-f__x86_64;intel-mkl-ps-f95-common__noarch;intel-mkl-ps-f__x86_64;intel-mkl-psxe__noarch;intel-psxe-common__noarch;intel-psxe-common-doc__noarch;intel-compxe-pset/g' silent.cfg && \
  sed -i 's/COMPONENTS=DEFAULTS/COMPONENTS=;intel-comp-l-all-vars__noarch;intel-openmp-l-all__x86_64;intel-openmp-l-ps-libs__x86_64;intel-tbb-libs__noarch;intel-mkl-common__noarch;intel-mkl-sta-common__noarch;intel-mkl__x86_64;intel-mkl-rt__x86_64;intel-mkl-gnu__x86_64;intel-mkl-gnu-rt__x86_64;intel-mkl-ps-common__noarch;intel-mkl-ps-common-64bit__x86_64;intel-mkl-common-c__noarch;intel-mkl-common-c-64bit__x86_64;intel-mkl-ps-common-c__noarch;intel-mkl-ps-ss-tbb__x86_64;intel-mkl-ps-ss-tbb-rt__x86_64;intel-mkl-gnu-c__x86_64;intel-mkl-ps-common-f__noarch;intel-mkl-ps-common-f-64bit__x86_64;intel-mkl-ps-gnu-f-rt__x86_64;intel-mkl-ps-gnu-f__x86_64;intel-mkl-ps-f95-common__noarch;intel-mkl-ps-f__x86_64;intel-mkl-psxe__noarch;intel-psxe-common__noarch;intel-compxe-pset/g' silent.cfg && \
  ./install.sh -s silent.cfg && \
  cd .. && rm -rf * && \
  rm -rf /opt/intel/.*.log /opt/intel/compilers_and_libraries_2017.4.196/licensing && \
  echo "/opt/intel/mkl/lib/intel64" >> /etc/ld.so.conf.d/intel.conf && \
  ldconfig && \
  echo "source /opt/intel/mkl/bin/mklvars.sh intel64" >> /etc/bash.bashrc

http://registrationcenter-download.intel.com/akdlm/irc_nas/tec/11544/l_mkl_2017.3.196.tgz

  http://registrationcenter-download.intel.com/akdlm/irc_nas/tec/11546/l_daal_2017.3.196.tgz

  http://registrationcenter-download.intel.com/akdlm/irc_nas/tec/11545/l_ipp_2017.3.196.tgz

  http://registrationcenter-download.intel.com/akdlm/irc_nas/tec/11526/l_tbb_2017.6.196.tgz

  http://registrationcenter-download.intel.com/akdlm/irc_nas/tec/11595/l_mpi_2017.3.196.tgz

  ENV MKLROOT=


sudo apt-get update && sudo apt-get install liblapack-dev liblapack-doc-man liblapack-doc liblapack-pic liblapack3 liblapack-test liblapacke liblapacke-dev libatlas-dev \
 openjdk-8-jdk gcc g++ gfortran \
 libpcre3-dev libqhull-dev libbz2-dev libhdf5-dev libfftw3-dev \
 libglpk-dev libcurl4-gnutls-dev libfreetype6-dev \
 libparpack2 libncurses5-dev libreadline6-dev \
 gperf flex bison gnuplot libfltk1.3-dev libarpack++2-dev libqrupdate-dev \
 libosmesa6-dev libqt5scintilla2-dev libqscintilla2-dev \
 libxft-dev libqt4-opengl-dev libgl2ps-dev
  ./configure --with-blas="-Wl,--start-group -lmkl_intel_lp64 -lmkl_intel_thread -lmkl_core -Wl,--end-group -liomp5 -lpthread" --with-lapack="-Wl,--start-group -lmkl_intel_lp64 -lmkl_intel_thread -lmkl_core -Wl,--end-group -liomp5 -lpthread" --enable-64

#pkg load package_name
sudo apt-add-repository ppa:octave/stable
sudo apt-get update && sudo apt-get install --yes octave octave-signal octave-control liboctave4 liboctave-dev