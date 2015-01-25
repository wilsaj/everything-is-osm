FROM jupyter/minimal

USER root

# grab gosu for easy step-down from root
RUN gpg --keyserver pgp.mit.edu --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/* \
	&& curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture)" \
	&& curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture).asc" \
	&& gpg --verify /usr/local/bin/gosu.asc \
	&& rm /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu \
	&& apt-get purge -y --auto-remove curl

RUN locale-gen en_US en_US.UTF-8
RUN dpkg-reconfigure locales

COPY ansible_hosts /ansible_hosts
COPY bootstrap_ansible.sh /bootstrap_ansible.sh
COPY ansible /ansible/
COPY variables.yml /variables.yml

RUN apt-get update \
    && apt-get -y install \
        ansible \
        golang \
        git \
        libgeos++-dev \
        libleveldb-dev \
        libprotobuf-dev \
        libsqlite3-dev \
        mercurial \
        openssh-server \
        postgresql-9.3 \
        postgresql-9.3-postgis-2.1 \
        python-apt \
        python-psycopg2 \
    && /bootstrap_ansible.sh setup import \
    && apt-get -y purge --auto-remove \
        ansible \
        git \
        golang \
        libgeos++-dev \
        libleveldb-dev \
        libprotobuf-dev \
        libsqlite3-dev \
        mercurial \
        openssh-server \
        python-apt

RUN pip install \
    geojsonio \
    ipython-sql \
    psycopg2 \
    shapely

COPY docker-entrypoint.sh /docker-entrypoint.sh

ADD notebooks/ /home/jovyan/

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/bin/bash"]
