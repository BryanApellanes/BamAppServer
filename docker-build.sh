#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: docker-build.sh\r\n"
    printf "\r\n"
    printf "Builds a docker image for the current state of the project."
    printf "\r\n"
    exit 0
fi

APPNAME=$(<defaultappname)
docker build -t ${APPNAME}-debug . -f debug.Dockerfile
docker build -t ${APPNAME} . -f Dockerfile