FROM nvidia/cuda:8.0-cudnn6-devel-centos7
##
##  Influeces taken from:
##  
##	* jupyter/docker-stacks
##	* Kaggle/docker-python
##	* Kaggle/docker-rstats
##	* Kaggle/docker-julia

MAINTAINER Josh Cole <jwcole1@qinetiq.com>

# Configure environment
ENV DEBIAN_FRONTEND=noninteractive SHELL=/bin/bash NAME=centos-base-data-science

# The Basics
RUN	yum -y update && yum -y upgrade && yum -y install yum-utils sudo locales && yum clean all

CMD ["/bin/bash"]