FROM qinetiq/docker-data-science:latest

MAINTAINER Josh Cole <jwcole1@qinetiq.com>



USER $DATASCI_USER

# RUN $CONDA_BIN/conda install --yes -c conda-cluster spark
RUN $CONDA_BIN/conda install --yes -c conda-forge pyspark
# ADD Scripts/install_jupyter_kernels.sh.sh /tmp/install_jupyter_kernels.sh
# RUN bash /tmp/install_jupyter_kernels.sh

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