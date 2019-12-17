#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: install-aws-cli.sh\r\n"
    printf "\r\n"
    printf "Downloads and installs the linux version of aws cli tools.\r\n"
    printf "\r\n"
    exit 0;
fi

# install python3 for aws cli support
apt-get update \
    && apt-get install -y --no-install-recommends python3

curl -O https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py --user
pip3 install awscli --upgrade --user
aws --version