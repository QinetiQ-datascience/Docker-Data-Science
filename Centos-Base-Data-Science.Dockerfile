FROM nvidia/cuda:8.0-cudnn6-devel-centos7

MAINTAINER Josh Cole <jwcole1@qinetiq.com>

# Configure environment
ENV DEBIAN_FRONTEND=noninteractive SHELL=/bin/bash NAME=ubuntu-base-data-science DATASCI_USER=datasci DATASCI_UID=1000 
ENV HOME=/home/$DATASCI_USER
ENV CONDA_DIR=/opt/conda CONDA_SRC=/usr/local/src/conda
ENV PATH $CONDA_DIR/bin:$HOME/.local/bin:$PATH
ENV IHaskell=/opt/IHaskell Cling=/opt/clingkernel
ENV Documents=$HOME/Documents Downloads=$HOME/Downloads Workspace=$HOME/Workspace

# SHA Currently failing
ENV TINI_VERSION=v0.15.0 TINI_CHECKSUM=595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 TINI_DIR=/opt/tini GOLANG_VERSION=1.8.3
ENV JDK_VERSION=8u141

ADD Scripts/Linux/setup_datasci_user.sh /tmp/setup_datasci_user.sh
ADD Scripts/Repos/dnf-stack-el7.repo /etc/yum.repos.d/dnf-stack-el7.repo
RUN bash /tmp/setup_datasci_user.sh

ENV LANG=en_GB.UTF-8 LANGUAGE=en_GB:en  LC_ALL=en_GB.UTF-8

VOLUME ["$Documents", "$Downloads", "$Workspace"]

USER $DATASCI_USER

ENV ANACONDA_VERSION=Anaconda3-4.4.0-Linux-x86_64 GHC_VERSION=8.2.1

ADD Scripts/Conda/install_anaconda.sh /tmp/install_anaconda.sh
RUN bash /tmp/install_anaconda.sh

USER root 

RUN chown -R $DATASCI_USER:redhawk $HOME

# ~~~~ CLEAN UP ~~~~
RUN yum update -y && yum upgrade -y && yum autoremove -y && yum clean all && \
	rm -rf /var/lib/apt-get/lists/* && \
	rm -rf /src/*.deb && \
    rm -rf $CONDA_SRC/* && \
    rm -rf /tmp/*

COPY Scripts/Jupyter/jupyter_notebook_config.py /etc/jupyter/
RUN chown -R $DATASCI_USER:$DATASCI_USER /etc/jupyter/

# Expose Port For Rstudio and Jupyter
EXPOSE 8787 8888-9000


# Generate machine id
RUN /usr/bin/dbus-uuidgen > /etc/machine-id
RUN mkdir -p /etc/selinux/targeted/contexts/
RUN echo '<busconfig><selinux></selinux></busconfig>' > /etc/selinux/targeted/contexts/dbus_contexts
USER $DATASCI_USER

RUN rm -rf $HOME/.cache/pip/* && conda clean -i -l -t --yes
# RUN pip install virtualenv virtualenvwrapper

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/bin/bash"]
