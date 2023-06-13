#!/bin/bash
set -x

apk add --no-cache jq

curl --interface uesimtun0 -w %{json} --url https://www.cia.gov/the-world-factbook/about/archives/download/factbook-2020.zip?$RANDOM --silent --output /dev/null | jq -c '. + {"test": "over5g"}' >> /proc/1/fd/1 | tee over5g.json

curl --interface eth0 -w %{json} --url https://www.cia.gov/the-world-factbook/about/archives/download/factbook-2020.zip?$RANDOM --silent --output /dev/null | jq -c '. + {"test": "overinternet"}' >> /proc/1/fd/1 | tee overinternet.json