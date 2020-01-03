#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: build.sh\r\n"
    printf "\r\n"
    printf "Builds a docker image for the current state of the project."
    printf "\r\n"
    exit 0
fi

source ./env.sh

CURDIR=`pwd`
cd $APPROOT
git pull --recurse-submodules
cd $CURDIR

printf "executing => 'docker build -t ${APPNAME}-debug ${APPROOT} -f ${DEBUGDOCKERFILE}'\r\n"
docker build -t ${APPNAME}-debug ${APPROOT} -f ${DEBUGDOCKERFILE}

printf "executing => 'docker build -t ${APPNAME} ${APPROOT} -f ${DOCKERFILE}'\r\n"
docker build -t ${APPNAME} ${APPROOT} -f ${DOCKERFILE}