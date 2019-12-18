#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: install-aws-cli.sh\r\n"
    printf "\r\n"
    printf "Downloads and installs the linux version of 'aws cli tools'.  This is used to\r\n"
    printf "install 'aws cli tools' in the container image and should not be used to install 'aws cli tools' for development;\r\n"
    printf "instead, you should use the installation method appropriate for your development environment.\r\n"
    printf "\r\n"
    exit 0;
fi

curl -O https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py --user
pip3 install awscli --upgrade --user
aws --version