#!/bin/bash
set -e

service postgresql start

if [ $1 = 'import' ]; then
    /bootstrap_ansible.sh import
  else
    exec "$@"
fi
