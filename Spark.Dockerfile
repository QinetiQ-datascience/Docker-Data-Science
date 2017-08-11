
FROM qinetiq/ubuntu-base-data-science:latest

MAINTAINER Josh Cole <jwcole1@qinetiq.com>

USER root

# ~~~~ CLEAN UP ~~~~
RUN apt-get update && apt-get --yes upgrade && apt-get --yes autoremove && apt-get clean && \
	rm -rf /var/lib/apt-get/lists/* && \
	rm -rf /src/*.deb && \
    rm -rf $CONDA_SRC/* && \
    rm -rf /tmp/*

USER $DATASCI_USER
CMD ["/bin/bash"]
