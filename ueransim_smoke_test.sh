#!/bin/bash

apk add --no-cache jq

curl -I ueransim0 -w %{json} --url https://yahoo.com --silent --output /dev/null | jq -c '. + {"test": "over5g"}' | tee over5g.json

curl -I eth0 -w %{json} --url https://yahoo.com --silent --output /dev/null | jq -c '. + {"test": "over5g"}' | tee overinternet.json