FROM ubuntu:14.04
MAINTAINER gamzabaw@gmail.com

RUN apt-get update \
 && apt-get install -y graphite-web python-psycopg2 expect

ADD local_settings.py /etc/graphite/local_settings.py
ADD syncdb.exp /syncdb.exp
ADD start /start

RUN chmod 755 /syncdb.exp
RUN chmod 755 /start

EXPOSE 8993/tcp
# VOLUME ["/var/lib/graphite/"]
CMD ["/start"]
