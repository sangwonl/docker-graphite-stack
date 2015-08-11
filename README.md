# docker-graphite-stack

A set of dockerfiles for simple stats monitoring by using following stacks.

StatsD + Carbon-Cache + Graphite + PostgreSQL + Dashing + Grafana

# Docker Containers Structure
![Docker Structure](https://github.com/sangwonl/docker-stats-monitoring/blob/master/overview.png "Docker Structure")

# Includes the following components

* [Grafana](https://github.com/grafana/grafana) - metrics dashboard and graph editor
* [Dashing](http://shopify.github.io/dashing/) - dashboard from shopify
* [Graphite](http://graphite.readthedocs.org/en/latest/) - front-end dashboard
* [Carbon](http://graphite.readthedocs.org/en/latest/carbon-daemons.html) - back-end
* [Statsd](https://github.com/etsy/statsd/wiki) - UDP based back-end proxy
* [PostgreSQL](http://www.postgresql.org/) - graphite web's db

**Note**: PostgreSQL docker files from https://github.com/sameersbn/docker-postgresql

# Container Mapped Ports

| Host | Container | Service           | Protocol |
| ---- | --------- | ----------------- | -------- |
| 3000 |      3000 | grafana           | HTTP     |
| 8893 |      8893 | graphite web      | HTTP     |
| 2003 |      2003 | carbon            | TCP      |
| 8125 |      8125 | statsd            | UDP      |
| 3030 |      3030 | dashing           | HTTP     |

# Mounted Volumes

| Host                | Container                  | Notes                           |
| ------------------- | -------------------------- | ------------------------------- |
| ./data/pgdata       | /var/lib/postgresql        | PostgreSQL Data Storage         |
| ./data/graphite     | /var/lib/graphite          | Graphite Data Storage           |
| ./data/grafana/lib  | /var/lib/grafana           | Grafana Data Storage            |
| ./data/grafana/log  | /var/log/grafana           | Grafana Log                     |
| ./data/grafana/etc  | /etc/grafana               | Grafana Config                  |


# Quick Start

### OSX

If you use OSX, it's recommended that you use vagrant for linux environment.

```sh
vagrant up
vagrant plugin install vagrant-vbguest
vagrant reload
vagrant provision
vagrant ssh

cd /vagrant
make all
make run
```

### Linux

```sh
make all
make run
```
