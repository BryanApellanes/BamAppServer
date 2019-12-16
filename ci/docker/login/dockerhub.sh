#!/bin/bash

source ./env.sh

export DOCKER_USER=`head -1 ./creds/${IMAGEREGISTRY} | tail -1`
export DOCKER_PASSWORD=`head -2 ./creds/${IMAGEREGISTRY} | tail -1`

printf "logging into docker => 'docker login ${REMOTEREGISTRY} -u $DOCKER_USER -p $DOCKER_PASSWORD'\r\n"
docker login ${REMOTEREGISTRY} -u $DOCKER_USER -p $DOCKER_PASSWORD