#!/bin/bash

USERNAME="osm"
PASSWORD="osm"
DB_NAME="osm"

CREATE_USER="CREATE USER $USERNAME WITH PASSWORD '$PASSWORD'"
echo "$CREATE_USER" | gosu postgres /usr/lib/postgresql/9.3/bin/postgres --single -D /var/lib/postgresql/data/ postgres

CREATE_DATABASE="CREATE DATABASE $DB_NAME OWNER $USERNAME"
echo "$CREATE_DATABASE" | gosu postgres /usr/lib/postgresql/9.3/bin/postgres --single -D /var/lib/postgresql/data/ postgres

# creating the postgis extension doesn't seem to work in single user mode, so we
# need to actually run the server to do it

# start server
gosu postgres pg_ctl -D /var/lib/postgresql/data start

# give it a moment to be able to accept connections
sleep 0.1

CREATE_POSTGIS="CREATE EXTENSION IF NOT EXISTS postgis"
gosu postgres /usr/lib/postgresql/9.3/bin/psql -c "$CREATE_POSTGIS" $DB_NAME

CREATE_HSTORE="CREATE EXTENSION IF NOT EXISTS hstore"
gosu postgres /usr/lib/postgresql/9.3/bin/psql -c "$CREATE_HSTORE" $DB_NAME

# stop server
gosu postgres pg_ctl -D /var/lib/postgresql/data stop
