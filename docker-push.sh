#!/bin/bash

IMAGE=$1
REMOTEREGISTRY=docker.io/bryanapellanes/$IMAGE

if [[ $# -eq 2 ]]; then
    REMOTEREGISTRY=$2
fi

docker tag $IMAGE $REMOTEREGISTRY
docker push $REMOTEREGISTRY