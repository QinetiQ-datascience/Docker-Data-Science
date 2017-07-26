set -e

npm install -g ijavascript

$CONDA_BIN/pip install -r /tmp/requirements_kernel.txt

$CONDA_BIN/python -m octave_kernel.install
$CONDA_BIN/python -m bash_kernel.install

mv $HOME/.local/share/jupyter/kernels/* $CONDA_DIR/share/jupyter/kernels/

$CONDA_BIN/jupyter kernelspec install $SAGE_ROOT/local/share/jupyter/kernels/sagemath
$SAGE_ROOT/local/bin/python2.7 -m pip install ipykernel
$SAGE_ROOT/local/bin/python2.7 -m ipykernel install

cd $IHaskell \
	&& stack setup \
	&& stack config set system-ghc --global true \
	&& stack install gtk2hs-buildtools \
	&& stack install --fast \
	&& stack exec ihaskell -- install --stack