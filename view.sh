#!/bin/bash

set -e

if [[ $# -eq 0 ]]
then
  jq -r '.[] | .title' store.json | cat -n | tail -r
  exit 0
fi

PATH=$(jq -r .[$1-1].path store.json)
if [[ "null" == $PATH ]]
then
  echo "That's not right!"
  exit 1
fi

/usr/bin/open "./store/$PATH"
