#!/bin/bash

curl -I ueransim0 -w "@/tmp/curl-format.txt" -o over5g.txt -s --url https://google.com

curl -I eth0 google.com -w "@/tmp/curl-format.txt" -o overinternet.txt -s --url https://google.com