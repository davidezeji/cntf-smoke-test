#!usr/bin/env bash
set -x

apk add --no-cache jq
# Test to run 200 curl commands to yahoo over 5G network and over the internet
for i in {1..5}; do
    # Run the first curl command over the 5G network
    curl --interface uesimtun0 -w %{json} --url https://yahoo.com?$RANDOM --silent --output /dev/null | jq -c '. + {"test": "over5g"}' | tee -a over5g.json

    # Run the second curl command over the internet 
    curl --interface eth0 -w %{json} --url https://yahoo.com?$RANDOM --silent --output /dev/null | jq -c '. + {"test": "overinternet"}' | tee -a overinternet.json
done
