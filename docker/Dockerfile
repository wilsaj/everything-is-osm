FROM ubuntu:14.04

ENV IMPOSM_VERSION 3b73f91a0d144524b6b9bac7011ffc9e90276e58

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
