#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: build.sh\r\n"
    printf "\r\n"
    printf "Builds a docker image for the current state of the project."
    printf "\r\n"
    exit 0
fi

source ./env.sh

printf "executing => 'docker build -t ${APPNAME}-debug ${IMAGEROOT} -f ${DEBUGDOCKERFILE}'\r\n"
docker build -t ${APPNAME}-debug ${IMAGEROOT} -f ${DEBUGDOCKERFILE}

printf "executing => 'docker build -t ${APPNAME} ${IMAGEROOT} -f ${DOCKERFILE}'\r\n"
docker build -t ${APPNAME} ${IMAGEROOT} -f ${DOCKERFILE}