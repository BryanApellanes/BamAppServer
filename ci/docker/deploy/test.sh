#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: test.sh\r\n"
    printf "\r\n"
    printf "Deploy the project to the test environment."
    printf "\r\n"
    exit 0;
fi

if [[ -z ${IMAGETAG} ]]; then
    IMAGETAG=$1
fi

echo "IMAGETAG = ${IMAGETAG}"
echo "TODO: add test deploy code here"