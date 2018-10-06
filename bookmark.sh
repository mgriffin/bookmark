#!/bin/bash

set -e

if [[ $# -eq 0 ]]
then
  echo "I need a website address"
  exit 1
fi

wget --force-directories --page-requisites --quiet $1

# Another option, taken from the wget manpage is to use this command
# wget -E -H -k -K -p http://<site>/<document>
