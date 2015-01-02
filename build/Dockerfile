FROM ubuntu:14.04


RUN apt-get update && \
    apt-get -y install \
        ansible  \
        python-apt \
        openssh-server \
        golang \
        git \
        libgeos++-dev \
        libleveldb-dev \
        libprotobuf-dev \
        libsqlite3-dev \
        mercurial \
        postgresql-9.3 \
        postgresql-9.3-postgis-2.1 \
        python-psycopg2 \
        ssl-cert

RUN locale-gen en_US en_US.UTF-8
RUN dpkg-reconfigure locales

COPY docker/everything-is-osm/ansible_hosts /ansible_hosts
COPY docker/everything-is-osm/bootstrap_ansible.sh /bootstrap_ansible.sh
COPY docker/everything-is-osm/docker-entrypoint.sh /docker-entrypoint.sh
COPY ansible /ansible/

COPY variables.yml /variables.yml
RUN /bootstrap_ansible.sh

ENTRYPOINT /docker-entrypoint.sh
