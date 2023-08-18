#!usr/bin/env bash

# this script updates the objects in the s3 bucket "cntf-open5gs-coralogix-test-results" with any changes made to their corresponding local files. 

udpate_s3() {
   aws s3 cp ./over5g.json s3://cntf-open5gs-test-results/over5g.json
   aws s3 cp ./overinternet.json s3://cntf-open5gs-test-results/overinternet.json
   aws s3 cp ./youtube-pupeteer-screenshot.png s3://cntf-open5gs-test-results/youtube-pupeteer-screenshot.png
   aws s3 cp ./youtube-pupeteer-load-time.txt s3://cntf-open5gs-test-results/youtube-pupeteer-load-time.txt
   aws s3 cp ./youtube-network-requests.txt s3://cntf-open5gs-test-results/youtube-network-requests.txt
}

udpate_s3
