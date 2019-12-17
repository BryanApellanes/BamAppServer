#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: release.sh\r\n"
    printf "\r\n"
    printf "Deploy the project to the release environment."
    printf "\r\n"
    exit 0;
fi

echo "TODO: add release deploy code here"