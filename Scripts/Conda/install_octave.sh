#!/bin/bash
set -e
conda uninstall --force --yes libedit
conda install --yes -c conda-forge octave=$OCTAVE_VERSION gnuplot octave_kernel oct2py
cp -p /lib/x86_64-linux-gnu/libreadline.so.6 $CONDA_DIR/lib


# cd /tmp &&  wget https://downloads.sourceforge.net/octave/control-3.0.0.tar.gz \
#     && wget https://downloads.sourceforge.net/octave/signal-1.3.2.tar.gz \
#     && wget https://downloads.sourceforge.net/octave/statistics-1.3.0.tar.gz \
#     && wget https://downloads.sourceforge.net/octave/io-2.4.7.tar.gz
#
# cd /tmp && octave --eval "pkg install control-3.0.0.tar.gz" \
#     && octave --eval "pkg install signal-1.3.2.tar.gz" \
#     && octave --eval "pkg install io-2.4.7.tar.gz"
