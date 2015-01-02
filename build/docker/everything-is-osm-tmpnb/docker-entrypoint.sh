#!/bin/bash
set -e

sudo service postgresql start

gosu jovyan "$@"
