#!/bin/bash

TYPE=$1
AREA=$2

DATA_DIR=/everything-is-osm
METRO_DIR=$DATA_DIR/metro

IMPOSM_BIN=/imposm3
IMPOSM_CACHE_DIR=$DATA_DIR/cache
MAPPING_JSON=/everything-is-osm/mapping.json

if [[ $TYPE == 'metro' ]]; then
    TYPE_DIR=$METRO_DIR
    FILENAME=${AREA}.osm.pbf
    URL="https://s3.amazonaws.com/metro-extracts.mapzen.com/${FILENAME}"
fi


PBF_FILEPATH=$TYPE_DIR/$FILENAME
DIR=$(dirname $PBF_FILEPATH)

mkdir -p $DIR
cd $DIR && curl -O $URL

mkdir -p $IMPOSM_CACHE_DIR

DB_SCHEMA=public
PG_CONNECT="postgis://osm:osm@$DB_PORT_5432_TCP_ADDR/osm"
$IMPOSM_BIN import -connection $PG_CONNECT -mapping $MAPPING_JSON -appendcache -cachedir=$IMPOSM_CACHE_DIR -read $PBF_FILEPATH 
$IMPOSM_BIN import -connection $PG_CONNECT -mapping $MAPPING_JSON -appendcache -cachedir=$IMPOSM_CACHE_DIR -write -dbschema-import=${DB_SCHEMA}
