FROM ubuntu:14.04
MAINTAINER gamzabaw@gmail.com

RUN apt-get update \
 && apt-get install -y software-properties-common python-software-properties python g++ make \
 && add-apt-repository -y ppa:chris-lea/node.js \
 && apt-get update && apt-get -f install -y nodejs git

RUN git clone https://github.com/etsy/statsd.git
RUN cd statsd && npm install

ADD localConfig.js /etc/statsd/localConfig.js
ADD start /start

RUN chmod 755 /start

EXPOSE 8125/udp
# VOLUME ["/data"]
CMD ["/start"]
