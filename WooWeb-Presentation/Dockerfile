
FROM joshcole/base-data-science-cpu:latest

MAINTAINER Josh Cole <jwcole1@qinetiq.com>

USER root

# Expose Ports
EXPOSE 6006 5000 5006

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 33D40BC6
RUN echo "deb http://rodeo-deb.yhat.com/ rodeo main\n" >> /etc/apt/sources.list
RUN add-apt-repository ppa:mystic-mirage/pycharm

ENV Training=$HOME/Training

RUN mkdir -p $Training
RUN chown -R $DATASCI_USER:$DATASCI_USER $Training

VOLUME ["$Documents", "$Downloads", "$Workspace", "$Training"]

# Install weka
RUN apt-get --yes update && apt-get install --yes weka

# jupyter
RUN apt-get --yes update && apt-get --yes install rodeo pycharm-community vim 

RUN ln -s /opt/Rodeo/rodeo /usr/bin/

# ~~~~ CLEAN UP ~~~~
RUN apt --yes update && apt --yes upgrade && apt --yes autoremove && apt clean && \
	apt purge --auto-remove  --yes curl && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /src/*.deb && \
    rm -rf $CONDA_SRC/* && \
    rm -rf /tmp/*

USER $DATASCI_USER

RUN cd $HOME/Training &&  git clone https://github.com/rhiever/Data-Analysis-and-Machine-Learning-Projects.git

RUN rm -rf $HOME/.cache/pip/*
RUN $CONDA_BIN/conda clean -i -l -t --yes

CMD /bin/bash