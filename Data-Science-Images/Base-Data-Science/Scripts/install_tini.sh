mkdir -p $TINI_DIR
cd $TINI_DIR
wget --quiet https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini
wget --quiet https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini.asc
gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 \
 && gpg --verify $TINI_DIR/tini.asc
chmod +x $TINI_DIR/tini
chown -R $DATASCI_USER:$DATASCI_USER $TINI_DIR
cp $TINI_DIR/tini /usr/bin/tini