# gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 \
#  && gpg --verify /tini.asc
# chmod +x /tini
# mv /tini /usr/local/bin/tini
wget --quiet https://github.com/krallin/tini/releases/download/v0.10.0/tini && \
echo "1361527f39190a7338a0b434bd8c88ff7233ce7b9a4876f3315c22fce7eca1b0 *tini" | sha256sum -c - && \
mv tini /usr/local/bin/tini && \
chmod +x /usr/local/bin/tini