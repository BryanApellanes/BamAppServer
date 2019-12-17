#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: staging.sh\r\n"
    printf "\r\n"
    printf "Deploy the project to the staging environment."
    printf "\r\n"
    exit 0;
fi

echo "TODO: add staging deploy code here"