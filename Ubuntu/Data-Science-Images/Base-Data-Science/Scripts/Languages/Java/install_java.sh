#!/bin/bash
set -e

# Install Java
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
add-apt-repository --yes ppa:webupd8team/java && \
apt-get update && \
apt-get install --yes  oracle-java8-installer oracle-java8-set-default && \
rm -rf /var/lib/apt/lists/* && \
rm -rf /var/cache/oracle-jdk8-installer