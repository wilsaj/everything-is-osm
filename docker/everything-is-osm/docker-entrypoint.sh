#!/bin/bash
set -e


if [ $1 = '/usr/lib/postgresql/9.3/bin/postgres' ]; then
    gosu postgres "$@"
  else
    exec "$@"
fi
