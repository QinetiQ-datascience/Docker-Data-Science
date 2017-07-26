set -e

$CONDA_BIN/conda update --all --yes
$CONDA_BIN/pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 $CONDA_BIN/pip install -U