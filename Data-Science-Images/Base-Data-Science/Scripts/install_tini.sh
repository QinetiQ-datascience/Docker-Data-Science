gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 \
 && gpg --verify /opt/tini/tini.asc
chmod +x /opt/tini/tini
chown -R $DATASCI_USER:$DATASCI_USER /opt/tini
cp /opt/tini/tini /usr/bin/tini