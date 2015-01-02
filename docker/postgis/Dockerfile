FROM postgres:9.3

RUN apt-get update \
    && apt-get install -y postgis

COPY init-database.sh /docker-entrypoint-initdb.d/init-database.sh
