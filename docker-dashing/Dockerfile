FROM ubuntu:14.04
MAINTAINER gamzabaw@gmail.com

RUN apt-get update \
 && apt-get install -y software-properties-common python-software-properties python g++ make \
 && add-apt-repository -y ppa:chris-lea/node.js \
 && apt-get update && apt-get -f install -y build-essential nodejs git ruby-full

RUN gem install dashing
RUN gem install bundler

# RUN dashing new sample_dashboard
RUN mkdir -p /dashboard
ADD dashboard /dashboard
RUN cd dashboard && bundle

ADD start /start
RUN chmod 755 /start

EXPOSE 3030/tcp
# VOLUME ["/data"]
CMD ["/start"]
