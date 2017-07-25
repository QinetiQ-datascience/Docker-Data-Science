
FROM joshcole/base-data-science-cpu:latest

MAINTAINER Josh Cole <jwcole1@qinetiq.com>

USER root

# Expose Ports
EXPOSE 6006
EXPOSE 5000
EXPOSE 5006

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 33D40BC6
RUN echo "deb http://rodeo-deb.yhat.com/ rodeo main\n" >> /etc/apt/sources.list
RUN add-apt-repository ppa:mystic-mirage/pycharm

RUN mkdir -p $HOME/Training
RUN chown -R $DATASCI_USER:$DATASCI_USER $HOME/Training 

# Rodeo GUI Requirements
RUN apt-get --yes update && apt-get --yes install  libxss1 libgconf-2-4 libnss3 libasound2

# Install weka
RUN apt-get --yes update && apt-get install --yes weka

# jupyter
RUN apt-get --yes update && apt-get --yes install rodeo pycharm-community vim 

RUN ln -s /opt/Rodeo/rodeo /usr/bin/

# Clean up
RUN apt-get --yes update && apt-get --yes upgrade && apt-get --yes autoremove
RUN apt-get clean \
		&& apt-get purge --auto-remove  -y curl \
		&& rm -rf /var/lib/apt/lists/* \
        && rm -rf /src/*.deb

# ~~~~ CLEAN UP ~~~~

RUN apt-get autoremove --yes && apt-get clean

USER $DATASCI_USER

RUN cd $HOME/Training &&  git clone https://github.com/rhiever/Data-Analysis-and-Machine-Learning-Projects.git

RUN rm -rf $HOME/.cache/pip/*
RUN $CONDA_BIN/conda clean -i -l -t --yes

CMD /bin/bash