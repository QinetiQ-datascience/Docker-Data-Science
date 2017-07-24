$CONDA_BIN/pip install -r /tmp/requirements_kernel.txt
$CONDA_BIN/pip install https://dist.apache.org/repos/dist/dev/incubator/toree/${TORRE_VERSION}/snapshots/dev1/toree-pip/toree-${TORRE_VERSION}.dev1.tar.gz

$CONDA_BIN/python -m octave_kernel.install --user
mv $HOME/.local/share/jupyter/kernels/octave* $CONDA_DIR/share/jupyter/kernels/

$CONDA_BIN/python -m bash_kernel.install --user

$CONDA_BIN/jupyter kernelspec install $SAGE_ROOT/local/share/jupyter/kernels/sagemath
$SAGE_ROOT/local/bin/python2.7 -m pip install ipykernel  --user
$SAGE_ROOT/local/bin/python2.7 -m ipykernel install --user

$CONDA_BIN/jupyter toree install --user --spark_home=$SPARK_HOME --interpreters=PySpark,SQL,Scala,SparkR

$CONDA_BIN/conda install --yes -c conda-forge spylon-kernel && $CONDA_BIN/python -m spylon_kernel install --user
