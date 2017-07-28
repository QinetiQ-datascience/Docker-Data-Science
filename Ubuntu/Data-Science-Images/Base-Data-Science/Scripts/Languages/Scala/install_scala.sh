#!/bin/bash
set -e
cd /tmp curl -fsL https://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C /usr/local/

rm -rf /tmp/scala-$SCALA_VERSION.tgz

# Install sbt
cd /tmp/ curl -L -o sbt-$SBT_VERSION.deb https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
dpkg -i sbt-$SBT_VERSION.deb && \
rm sbt-$SBT_VERSION.deb && \
apt-get update && \
apt-get --yes install sbt && apt-get clean all && rm -rf /var/lib/apt/lists/* && \
sbt sbtVersion