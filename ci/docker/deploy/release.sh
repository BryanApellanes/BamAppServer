#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: release.sh\r\n"
    printf "\r\n"
    printf "Deploy the project to the release environment."
    printf "\r\n"
    exit 0;
fi

if [[ -z ${IMAGETAG} ]]; then
    IMAGETAG=$1
fi

echo "Current context is ${PWD##*/}"
echo "IMAGETAG = ${IMAGETAG}"
echo "TODO: Add code to do DOCKER deployment to the 'release' environment here."