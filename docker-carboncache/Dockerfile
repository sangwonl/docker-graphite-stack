FROM ubuntu:14.04
MAINTAINER gamzabaw@gmail.com

RUN apt-get update \
 && apt-get install -y graphite-carbon

ADD graphite-carbon /etc/default/graphite-carbon
ADD carbon.conf /etc/carbon/carbon.conf
ADD storage-schemas.conf /etc/carbon/storage-schemas.conf
ADD storage-aggregation.conf /etc/carbon/storage-aggregation.conf
ADD start /start

RUN chmod 755 /start

EXPOSE 2003/tcp
# VOLUME ["/var/lib/graphite/"]
CMD ["/start"]
