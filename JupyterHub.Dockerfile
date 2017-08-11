
FROM qinetiq/ubuntu-base-data-science:latest

MAINTAINER Josh Cole <jwcole1@qinetiq.com>

USER root



LABEL org.jupyter.service="jupyterhub"

CMD ["jupyterhub"]