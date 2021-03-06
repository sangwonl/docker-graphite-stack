all: postgresql graphiteweb carboncache statsd dashing grafana

postgresql:
	docker build -t postgresql -f ./docker-postgresql/Dockerfile --rm ./docker-postgresql

graphiteweb:
	docker build -t graphiteweb -f ./docker-graphiteweb/Dockerfile --rm ./docker-graphiteweb

carboncache:
	docker build -t carboncache -f ./docker-carboncache/Dockerfile --rm ./docker-carboncache

statsd:
	docker build -t statsd -f ./docker-statsd/Dockerfile --rm ./docker-statsd

dashing:
	docker build -t dashing -f ./docker-dashing/Dockerfile --rm ./docker-dashing

grafana:
	docker build -t grafana -f ./docker-grafana/Dockerfile --rm ./docker-grafana

run:
	mkdir -p $(HOME)/data/pgdata $(HOME)/data/graphite $(HOME)/data/grafana/log $(HOME)/data/grafana/lib
	docker run -d --name postgresql -v $(HOME)/data/pgdata:/var/lib/postgresql -e 'DB_NAME=graphite' -e 'DB_USER=graphite' -e 'DB_PASS=graphite' postgresql
	sleep 3
	docker run -d --name graphitedata -v $(HOME)/data/graphite:/var/lib/graphite ubuntu:14.04 /bin/sh -c "while true; do ping 8.8.8.8; sleep 10; done"
	docker run -d --name graphiteweb --volumes-from graphitedata --link postgresql:postgresql -p 8993:8993 graphiteweb
	sleep 1
	docker run -d --name carboncache --volumes-from graphitedata -p 2003:2003 carboncache
	docker run -d --name statsd --link carboncache:carboncache -p 8125:8125/udp statsd
	docker run -d --name dashing --link graphiteweb:graphiteweb -p 3030:3030 dashing
	docker run -d --name grafana -v $(HOME)/data/grafana/lib:/var/lib/grafana -v $(HOME)/data/grafana/log:/var/log/grafana --link graphiteweb:graphiteweb -p 3000:3000 -e "GF_SECURITY_ADMIN_PASSWORD=admin" grafana

rm:
	docker rm -f `docker ps -a -q`
