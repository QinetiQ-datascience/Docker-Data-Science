FROM qinetiq/docker-data-science:latest

MAINTAINER Josh Cole <jwcole1@qinetiq.com>

USER root
##
##  SPARK Congiuration
##
ENV APACHE_SPARK_VERSION=2.2.0 HADOOP_VERSION=2.7 SPARK_HOME=/opt/spark MESOS_NATIVE_LIBRARY=/usr/local/lib/libmesos.so
ENV SPARK_HADOOP_CHECKSUM=7a186a2a007b2dfd880571f7214a7d329c972510a460a8bdbef9f7f2a891019343c020f74b496a61e5aa42bc9e9a79cc99defe5cb3bf8b6f49c07e01b259bc6b
ENV PYTHONPATH $SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.4-src.zip
ENV SPARK_OPTS --driver-java-options=-Xms1024M --driver-java-options=-Xmx4096M --driver-java-options=-Dlog4j.logLevel=info

ADD Scripts/install_spark.sh /tmp/install_spark.sh
RUN bash /tmp/install_spark.sh

USER $DATASCI_USER

ADD Scripts/install_jupyter_kernels.sh.sh /tmp/install_jupyter_kernels.sh
RUN bash /tmp/install_jupyter_kernels.sh

USER root 

# ~~~~ CLEAN UP ~~~~
RUN apt update && apt --yes upgrade && apt --yes autoremove && apt clean && \
	apt purge --auto-remove  --yes curl && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /src/*.deb && \
    rm -rf $CONDA_SRC/* && \
    rm -rf /tmp/*

RUN chown -R $DATASCI_USER:$DATASCI_USER $HOME

USER $DATASCI_USER

RUN rm -rf $HOME/.cache/pip/* && $CONDA_BIN/conda clean -i -l -t --yes

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/bin/bash"]