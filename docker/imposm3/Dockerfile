FROM ubuntu:14.04

ENV IMPOSM_VERSION 32623ccce097584be79ec8617dfae42d595ac2b8

# Build imposm3 binary and clean up afterwards
RUN apt-get update \
    && apt-get install -y golang \
    && apt-get install -y git \
    && apt-get install -y libgeos++-dev \
    && apt-get install -y libleveldb-dev \
    && apt-get install -y libprotobuf-dev \
    && apt-get install -y libsqlite3-dev \
    && apt-get install -y mercurial \
    && mkdir /imposm \
    && git clone https://github.com/omniscale/imposm3 /imposm/src/imposm3 \
    && cd /imposm/src/imposm3 \
    && git checkout $IMPOSM_VERSION \
    && GOPATH=/imposm go get imposm3 \
    && GOPATH=/imposm go build -o /imposm3 imposm3 \
    && cd / \
    && rm -rf /imposm \
    && apt-get purge -y --auto-remove golang \
    && apt-get purge -y --auto-remove git \
    && apt-get purge -y --auto-remove mercurial

RUN apt-get update \
    && apt-get install -y curl

VOLUME /everything-is-osm

COPY import.sh /import.sh
COPY mapping.json /everything-is-osm/mapping.json
RUN mkdir -p /everything-is-osm/metro
