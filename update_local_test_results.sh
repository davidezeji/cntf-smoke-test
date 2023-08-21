#!/usr/bin/env bash

# this file goes inside the youtube pupeteer container copies the updated logs from tests run, and stores them locally

YOUTUBE_PUPETEER_POD=$(kubectl -n openverso get pod --output=jsonpath={.items..metadata.name} -l puppeteer-script=youtube-search)

update_local_load_time () {
    kubectl cp -n openverso $YOUTUBE_PUPETEER_POD:load_time.txt ./youtube-pupeteer-load-time.txt 
}

update_local_picture () {
    kubectl cp -n openverso $YOUTUBE_PUPETEER_POD:youtube_invaders_video.png ./youtube-pupeteer-screenshot.png 
}

update_network_requests () {
    kubectl cp -n openverso $YOUTUBE_PUPETEER_POD:network_requests.txt ./youtube-network-requests.txt
}

update_local_load_time
update_local_picture
update_network_requests
