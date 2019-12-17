#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: install-aws-cli.sh\r\n"
    printf "\r\n"
    printf "Downloads and installs the linux version of aws cli tools.\r\n"
    printf "\r\n"
    exit 0;
fi

curl "https://d1vvhvl2y92vvt.cloudfront.net/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install