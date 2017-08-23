#!/bin/bash
set -e

sudo apt-get update && sudo apt-get install --yes libkrb5-dev

# Mesos dependencies
# sudo apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF && \
#     DISTRO=debian && \
#     CODENAME=jessie && \
#     sudo echo "deb http://repos.mesosphere.io/${DISTRO} ${CODENAME} main" > /etc/apt/sources.list.d/mesosphere.list && \
#     sudo apt-get --yes update && \
#     sudo apt-get --no-install-recommends --yes --allow-downgrades --allow-remove-essential --allow-change-held-packages install mesos=1.2\* && \
#     sudo apt-get clean && \
#     sudo rm -rf /var/lib/apt/lists/*

# echo "$SPARK_HADOOP_CHECKSUM *spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" | sha512sum -c - && \

# cd /tmp && wget -q http://d3kbcqa49mib13.cloudfront.net/spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
# tar xzf spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz -C /opt  && \
# rm spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

# sudo chown -R $DATASCI_USER:$DATASCI_USER $SPARK_HOME

# conda install --yes \
# 'r-sparklyr' \
#  && conda clean -tipsy

# # Apache Toree kernel
# # pip --no-cache-dir install https://dist.apache.org/repos/dist/dev/incubator/toree/0.2.0/snapshots/dev1/toree-pip/toree-0.2.0.dev1.tar.gz
# # jupyter toree install --sys-prefix --interpreters=Scala,PySpark,SparkR,SQL

# # Spylon-kernel
# conda install --yes -c conda-forge spylon-kernel PySpark && \
# conda clean -tipsy

# python -m spylon_kernel install --sys-prefix

# pip install sparkmagic


cd /opt/ && sudo wget https://s3.eu-central-1.amazonaws.com/spark-notebook/tgz/spark-notebook-0.7.0-pre2-scala-2.11.7-spark-1.6.2-hadoop-2.7.3-with-hive-with-parquet.tgz && \
sudo tar zxvf spark-notebook-0.7.0-pre2-scala-2.11.7-spark-1.6.2-hadoop-2.7.3-with-hive-with-parquet.tgz