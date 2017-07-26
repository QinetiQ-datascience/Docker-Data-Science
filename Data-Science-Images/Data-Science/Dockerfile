
FROM joshcole/spark-data-science:latest

MAINTAINER Josh Cole <jwcole1@qinetiq.com>

USER root

ENV NLTK_DATA=/usr/share/nltk_data

ADD Scripts/requirements.txt /tmp/requirements.txt
ADD Scripts/install_python_pkgs_from_src.sh /tmp/install_python_pkgs_from_src.sh
ADD Scripts/cache_keras_weights.py $CONDA_SRC/cache_keras_weights.py
ADD Scripts/package_installs.jl /tmp/package_installs.jl
ADD Scripts/install_julia_pkgs_from_src.sh /tmp/install_julia_pkgs_from_src.sh
ADD Scripts/install_r_pkgs_from_src.sh /tmp/install_r_pkgs_from_src.sh
ADD Scripts/RProfile.R /tmp/RProfile.R
ADD Scripts/bioconductor_installs.R /tmp/bioconductor_installs.R
ADD Scripts/install_iR.R /tmp/install_iR.R
ADD Scripts/package_installs.R /tmp/package_installs.R

RUN mkdir -p $CONDA_SRC && mkdir $NLTK_DATA
RUN chown -R $DATASCI_USER:$DATASCI_USER $CONDA_SRC && chown -R $DATASCI_USER:$DATASCI_USER $NLTK_DATA

USER $DATASCI_USER

RUN bash /tmp/anaconda-install_pkgs_from_src.sh
RUN $CONDA_BIN/pip install -r /tmp/requirements.txt --upgrade

RUN julia /tmp/package_installs.jl && bash /tmp/install_julia_pkgs_from_src.sh

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