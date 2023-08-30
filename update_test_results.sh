#!/usr/bin/env bash

# this script outputs test data from within the "ueransim-gnb-ues" pod and into local files called "over5g.json" & "overinternet.json", then it reflects any changes made to these local files in S3.
   
UE_POD=$(kubectl -n openverso get pod --output=jsonpath={.items..metadata.name} -l pod-template-hash=697554b858)

update_local_test_data () {
   kubectl -n openverso cp $UE_POD:/over5g.json ./over5g.json
   kubectl -n openverso cp $UE_POD:/overinternet.json ./overinternet.json
}

udpate_s3() {
   aws s3 cp ./over5g.json s3://cntf-open5gs-test-results/over5g.json
   aws s3 cp ./overinternet.json s3://cntf-open5gs-test-results/overinternet.json
}

update_local_test_data
udpate_s3
