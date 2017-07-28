#!/bin/bash
set -e

# Scala repo
cd /tmp && curl -sSL http://apt.typesafe.com/repo-deb-build-0002.deb  -o repo-deb.deb  && \
dpkg -i repo-deb.deb  && rm  repo-deb.deb && apt-get update

# Install Scala
apt-get install --yes libjansi-java && apt-get clean all && rm -rf /var/lib/apt/lists/* && \
cd /tmp && curl -sSL http://www.scala-lang.org/files/archive/scala-$SCALA_VERSION.deb -o scala.deb && \
dpkg -i scala.deb && rm scala.deb

# Install sbt
cd /tmp/ && curl -L -o sbt-$SBT_VERSION.deb https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
dpkg -i sbt-$SBT_VERSION.deb && \
rm sbt-$SBT_VERSION.deb && \
apt-get update && \
apt-get --yes install sbt && apt-get clean all && rm -rf /var/lib/apt/lists/* && \
sbt sbtVersion