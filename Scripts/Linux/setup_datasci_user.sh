#!/bin/bash
set -e

useradd -m --shell /bin/bash --uid $DATASCI_UID --user-group $DATASCI_USER

mkdir -p $CONDA_DIR && chown $DATASCI_USER $CONDA_DIR

# Change ownership
chown -R $DATASCI_USER:$DATASCI_USER $CONDA_DIR

# Users passwords
echo "$DATASCI_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
echo "root:$DATASCI_USER" | chpasswd && echo "$DATASCI_USER:$DATASCI_USER" | chpasswd

mkdir -p $CONDA_SRC && chown -R $DATASCI_USER:$DATASCI_USER $CONDA_SRC
mkdir -p $Documents && chown -R $DATASCI_USER:$DATASCI_USER $Documents
mkdir -p $Downloads && chown -R $DATASCI_USER:$DATASCI_USER $Downloads
mkdir -p $Workspace && chown -R $DATASCI_USER:$DATASCI_USER $Workspace

apt-get update && apt-get install -yq --no-install-recommends \
wget \
curl \
bzip2 \
unzip \
ca-certificates \
fonts-liberation \
software-properties-common \
python-software-properties \
vim nano \
net-tools netcat rsync \
git subversion mercurial \
libgl1-mesa-glx graphviz && \
apt-get clean && \
rm -rf /var/lib/apt/lists/*

add-apt-repository ppa:ubuntu-x-swat/updates
apt-get update && apt-get dist-upgrade --yes && \
apt-get clean && \
rm -rf /var/lib/apt/lists/*

# add-apt-repository ppa:ubuntu-toolchain-r/test
apt-get update && apt-get install --yes gcc gfortran libx11-dev libboost-all-dev libboost-dev \
libgeos++-dev libv8-dev libgdal-dev && \
apt-get clean && \
rm -rf /var/lib/apt/lists/*
# gcc-7 g++-7 libgcc-7-dev libstdc++-7-dev gfortran-7 \

apt-get update && apt-get install --yes --no-install-recommends dbus hicolor-icon-theme libappindicator1 libatk1.0-0 libatk1.0-data \
libavahi-client3 libavahi-common-data libavahi-common3 libcap-ng0 libcups2 \
libdbusmenu-glib4 libdbusmenu-gtk4 libgdk-pixbuf2.0-0 \
libgdk-pixbuf2.0-common libgtk2.0-0 libgtk2.0-bin libgtk2.0-common \
libindicator7 libnotify-bin libnotify4 libpam-systemd libxcomposite1 \
libxcursor1 libxi6 libxinerama1 libxrandr2 shared-mime-info indicator-application notification-daemon \
dbus-user-session dbus-x11 cups-common librsvg2-common gvfs && \
apt-get clean && \
rm -rf /var/lib/apt/lists/*


mkdir -p $TINI_DIR
cd $TINI_DIR
wget --quiet https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini
# wget --quiet https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini.asc
# gpg --keyserver ha.pool.sks-keyservers.net --recv-keys $TINI_CHECKSUM
# gpg --verify $TINI_DIR/tini.asc
chmod +x $TINI_DIR/tini
chown -R $DATASCI_USER:$DATASCI_USER $TINI_DIR
cp $TINI_DIR/tini /usr/bin/tini

usermod -aG audio,video $DATASCI_USER
ln -s /bin/tar /bin/gtar
