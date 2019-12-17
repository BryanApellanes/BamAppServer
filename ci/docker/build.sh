#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: build.sh\r\n"
    printf "\r\n"
    printf "Builds a docker image for the current state of the project."
    printf "\r\n"
    exit 0
fi

source ./env.sh

printf "executing => 'docker build -t ${APPNAME}-debug ${DOCKERIMAGEROOT} -f ${DEBUGDOCKERFILE}'\r\n"
docker build -t ${APPNAME}-debug ${DOCKERIMAGEROOT} -f ${DEBUGDOCKERFILE}

printf "executing => 'docker build -t ${APPNAME} ${DOCKERIMAGEROOT} -f ${DOCKERFILE}'\r\n"
docker build -t ${APPNAME} ${DOCKERIMAGEROOT} -f ${DOCKERFILE}