#!/bin/bash
set -x

apk add --no-cache jq

curl -i ueransim0 -w %{json} --url https://yahoo.com --silent --output /dev/null | jq -c '. + {"test": "over5g"}' | tee over5g.json

curl -i eth0 -w %{json} --url https://yahoo.com --silent --output /dev/null | jq -c '. + {"test": "over5g"}' | tee overinternet.json