
FROM qinetiq/ubuntu-base-data-science:latest

MAINTAINER Josh Cole <jwcole1@qinetiq.com>
USER $DATASCI_USER
RUN conda install --yes -c conda-forge jupyterhub

USER root

# ~~~~ CLEAN UP ~~~~
RUN apt-get update && apt-get --yes upgrade && apt-get --yes autoremove && apt-get clean && \
	rm -rf /var/lib/apt-get/lists/* && \
	rm -rf /src/*.deb && \
    rm -rf $CONDA_SRC/* && \
    rm -rf /tmp/*

LABEL org.jupyter.service="jupyterhub"

CMD ["jupyterhub"]