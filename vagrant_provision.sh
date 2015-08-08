#!/bin/bash
set -e

export DEBIAN_FRONTEND=noninteractive
apt-get -q update
apt-get -y --force-yes install wget \
  && wget -qO- https://get.docker.com/ | sh \
  && usermod -aG docker vagrant
