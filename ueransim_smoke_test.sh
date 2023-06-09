#!/bin/bash

curl -I ueransim0 -w "@curl-format.txt" -o over5g.txt -s --url https://google.com

curl -I eth0 google.com -w "@curl-format.txt" -o overinternet.txt -s --url https://google.com