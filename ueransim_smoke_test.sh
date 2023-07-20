#!usr/bin/env bash
set -x

apk add --no-cache jq

curl --interface uesimtun0 -w %{json} --url https://yahoo.com?$RANDOM --silent --output /dev/null | jq -c '. + {"test": "over5g"}' | tee over5g.json

curl --interface eth0 -w %{json} --url https://yahoo.com?$RANDOM --silent --output /dev/null | jq -c '. + {"test": "overinternet"}' | tee overinternet.json

# https://www.cia.gov/the-world-factbook/about/archives/download/factbook-2020.zip?$RANDOM
