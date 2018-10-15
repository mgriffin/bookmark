#!/bin/bash

set -e

if [[ $# -eq 0 ]]
then
  echo "I need a website address"
  exit 1
fi

URL=$1
DATE=$(date "+%Y-%m-%dT%H:%M:%S")
TITLE=$(curl -s $URL | grep -io "<title>[^\<]*" | cut -f2 -d'>')
PATH=$(basename $URL | sed 's!.*/!!' | sed '/\.html/ ! s/$/\/index.html/')

pushd store > /dev/null
/usr/local/bin/wget --force-directories --page-requisites --quiet $URL && echo "yay"
popd > /dev/null
/usr/local/bin/jq --arg URL $URL --arg TITLE "$TITLE" --arg PATH $PATH --arg DATE $DATE '. += [{"url":$URL,"title":$TITLE,"path":$PATH,"date":$DATE}]' store.json > store.json.tmp && /bin/mv store.json.tmp store.json

# Another option, taken from the wget manpage is to use this command
# wget -E -H -k -K -p http://<site>/<document>
