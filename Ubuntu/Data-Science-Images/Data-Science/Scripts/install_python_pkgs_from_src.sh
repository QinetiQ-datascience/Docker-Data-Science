#xgboost
cd $CONDA_SRC && mkdir xgboost && cd xgboost && \
git clone --depth 1 --recursive https://github.com/dmlc/xgboost.git && cd xgboost && \
make && cd python-package && $CONDA_BIN/python setup.py install

#lasagne
cd $CONDA_SRC && mkdir Lasagne && cd Lasagne && \
git clone --depth 1 https://github.com/Lasagne/Lasagne.git && cd Lasagne && \
$CONDA_BIN/pip install -r requirements.txt && $CONDA_BIN/python setup.py install

#keras
cd $CONDA_SRC && mkdir keras && cd keras && \
git clone --depth 1 https://github.com/fchollet/keras.git && \
cd keras && $CONDA_BIN/python setup.py install

#keras-rl
cd $CONDA_SRC && mkdir keras-rl && cd keras-rl && \
git clone --depth 1 https://github.com/matthiasplappert/keras-rl.git && \
cd keras-rl && $CONDA_BIN/python setup.py install

#neon
cd $CONDA_SRC && \
git clone --depth 1 https://github.com/NervanaSystems/neon.git && \
cd neon && $CONDA_BIN/pip install -e .

#nolearn
cd $CONDA_SRC && mkdir nolearn && cd nolearn && \
git clone --depth 1 https://github.com/dnouri/nolearn.git && cd nolearn && \
echo "x" > README.rst && echo "x" > CHANGES.rst && \
$CONDA_BIN/python setup.py install

# Dev branch of Theano
$CONDA_BIN/pip install git+git://github.com/Theano/Theano.git --upgrade --no-deps

# put theano compiledir inside /tmp (it needs to be in writable dir)
printf "[global]\nbase_compiledir = /tmp/.theano\n" > $HOME/.theanorc && \
cd $CONDA_SRC &&  git clone --depth 1 https://github.com/pybrain/pybrain && \
cd pybrain && $CONDA_BIN/python setup.py install

# NOTE: we provide the tsne package, but sklearn.manifold.TSNE now does the same
# job
cd $CONDA_SRC && git clone --depth 1 https://github.com/danielfrg/tsne.git && \
cd tsne && $CONDA_BIN/python setup.py install

cd $CONDA_SRC && git clone --depth 1 https://github.com/ztane/python-Levenshtein && \
cd python-Levenshtein && $CONDA_BIN/python setup.py install

cd $CONDA_SRC && git clone --depth 1 https://github.com/arogozhnikov/hep_ml.git && \
cd hep_ml && $CONDA_BIN/pip install .

# NLTK Project datasets
# NLTK Downloader no longer continues smoothly after an error, so we explicitly list
# the corpuses that work
mkdir -p $NLTK_DATA && \
$CONDA_BIN/python -m nltk.downloader -d /usr/share/nltk_data abc alpino averaged_perceptron_tagger \
basque_grammars biocreative_ppi bllip_wsj_no_aux \
book_grammars brown brown_tei cess_cat cess_esp chat80 city_database cmudict \
comtrans conll2000 conll2002 conll2007 crubadan dependency_treebank \
europarl_raw floresta gazetteers genesis gutenberg hmm_treebank_pos_tagger \
ieer inaugural indian jeita kimmo knbc large_grammars lin_thesaurus mac_morpho machado \
masc_tagged maxent_ne_chunker maxent_treebank_pos_tagger moses_sample movie_reviews \
mte_teip5 names nps_chat omw opinion_lexicon paradigms \
pil pl196x porter_test ppattach problem_reports product_reviews_1 product_reviews_2 propbank \
pros_cons ptb punkt qc reuters rslp rte sample_grammars semcor senseval sentence_polarity \
sentiwordnet shakespeare sinica_treebank smultron snowball_data spanish_grammars \
state_union stopwords subjectivity swadesh switchboard tagsets timit toolbox treebank \
twitter_samples udhr2 udhr unicode_samples universal_tagset universal_treebanks_v20 \
vader_lexicon verbnet webtext word2vec_sample wordnet wordnet_ic words ycoe

cd $CONDA_SRC && $CONDA_BIN/python cache_keras_weights.py

# Install OpenCV-3 with Python support
# Anaconda's build of gcc is way out of date; monkey-patch some linking problems that affect
# packages like xgboost and Shapely
rm $CONDA_DIR/lib/libstdc++* && rm $CONDA_DIR/lib/libgomp.* && \
ln -s /usr/lib/x86_64-linux-gnu/libgomp.so.1 $CONDA_DIR/lib/libgomp.so.1 && \
ln -s /usr/lib/x86_64-linux-gnu/libstdc++.so.6 $CONDA_DIR/lib/libstdc++.so.6

cd $CONDA_SRC && git clone https://github.com/matplotlib/basemap.git && \
export GEOS_DIR=/usr/local && \
cd basemap && $CONDA_BIN/python setup.py install


cd $CONDA_SRC && git clone https://github.com/vitruvianscience/opendeep.git && \
cd opendeep && $CONDA_BIN/python setup.py develop

cd $CONDA_SRC && git clone https://github.com/Toblerity/Shapely.git && \
cd Shapely && $CONDA_BIN/python setup.py install && \
cd $CONDA_SRC && git clone https://github.com/SciTools/cartopy.git && \
cd cartopy && $CONDA_BIN/python setup.py install

    # MXNet
cd $CONDA_SRC && git clone --recursive https://github.com/dmlc/mxnet && \
cd $CONDA_SRC/mxnet && cp make/config.mk . && \
sed -i 's/ADD_LDFLAGS =/ADD_LDFLAGS = -lstdc++/' config.mk && \
make && cd python && $CONDA_BIN/python setup.py install

    # set backend for matplotlib to Agg
matplotlibrc_path=$($CONDA_BIN/python -c "import site, os, fileinput; packages_dir = site.getsitepackages()[0]; print(os.path.join(packages_dir, 'matplotlib', 'mpl-data', 'matplotlibrc'))") && \
sed -i 's/^backend      : Qt5Agg/backend      : Agg/' $matplotlibrc_path  && \
# Stop jupyter nbconvert trying to rewrite its folder hierarchy
mkdir -p $HOME/.jupyter && touch $HOME/.jupyter/jupyter_nbconvert_config.py && touch $HOME/.jupyter/migrated && \
touch $HOME/.jupyter/jupyter_nbconvert_config.py && touch $HOME/.jupyter/migrated && \
# Stop Matplotlib printing junk to the console on first load
sed -i "s/^.*Matplotlib is building the font cache using fc-list.*$/# Warning removed by Kaggle/g" $CONDA_DIR/lib/python3.6/site-packages/matplotlib/font_manager.py && \
# Make matplotlib output in Jupyter notebooks display correctly
echo "c = get_config(); c.IPKernelApp.matplotlib = 'inline'" > /etc/ipython/ipython_config.py

# h2o
cd $CONDA_SRC && mkdir h2o && cd h2o && \
wget http://h2o-release.s3.amazonaws.com/h2o/latest_stable -O latest && \
wget --no-check-certificate -i latest -O h2o.zip && rm latest && \
unzip h2o.zip && rm h2o.zip && cp h2o-*/h2o.jar . && \
$CONDA_BIN/pip install `find . -name "*whl"`

# Keras setup
# Keras likes to add a config file in a custom directory when it's
# first imported. This doesn't work with our read-only filesystem, so we
# have it done now
$CONDA_BIN/python -c "from keras.models import Sequential"  && \
# Switch to TF backend
sed -i 's/theano/tensorflow/' $HOME/.keras/keras.json

# Re-it to flush any more disk writes
$CONDA_BIN/python -c "from keras.models import Sequential; from keras import backend; print(backend._BACKEND)" && \
# Keras reverts to /tmp from ~ when it detects a read-only file system
mkdir -p /tmp/.keras && cp $HOME/.keras/keras.json /tmp/.keras

# Scikit-Learn nightly build
cd $CONDA_SRC && git clone https://github.com/scikit-learn/scikit-learn.git && \
cd scikit-learn && $CONDA_BIN/python setup.py build && $CONDA_BIN/python setup.py install

# Regularized Greedy Forests
cd $CONDA_SRC && wget https://github.com/fukatani/rgf_python/releases/download/0.2.0/rgf1.2.zip && \
unzip rgf1.2.zip && cd rgf1.2 && make

cd $CONDA_SRC && git clone https://github.com/fukatani/rgf_python.git && \
cd rgf_python && sed -i 's/\/opt\/rgf1.2\/bin\/rgf/\/usr\/local\/bin\/rgf/' rgf/sklearn.py && \
$CONDA_BIN/python setup.py install

# Imbalanced-learn
cd $CONDA_SRC && git clone https://github.com/scikit-learn-contrib/imbalanced-learn.git && \
cd imbalanced-learn && $CONDA_BIN/python setup.py install

# Boruta (python implementation)
cd $CONDA_SRC && git clone https://github.com/danielhomola/boruta_py.git && \
cd boruta_py && $CONDA_BIN/python setup.py install

cd $CONDA_SRC && git clone --recursive --depth 1 https://github.com/Microsoft/LightGBM && \
cd LightGBM && mkdir build && cd build && cmake .. && make -j $(nproc) && \
cd $CONDA_SRC/LightGBM/python-package && $CONDA_BIN/python setup.py install

cd $CONDA_SRC && git clone git://github.com/nicolashennetier/pyeconometrics.git && \
cd pyeconometrics && $CONDA_BIN/python setup.py install

GDAL_CONFIG=/usr/bin/gdal-config && \
cd $CONDA_SRC && git clone git://github.com/scikit-learn-contrib/py-earth.git && \
cd py-earth && $CONDA_BIN/python setup.py install
