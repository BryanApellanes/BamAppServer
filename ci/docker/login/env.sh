#!/bin/bash

if [[ -z $IMAGEREGISTRY ]]; then
    export IMAGEREGISTRY=$(<${DOCKERIMAGEROOT}defaultimageregistry)
    printf "login using IMAGEREGISTRY ${IMAGEREGISTRY}"
fi

if [[ -z $REMOTEREGISTRY ]]; then
    export REMOTEREGISTRY=$(<registries/${IMAGEREGISTRY})
    printf "login using REMOTEREGISTRY ${REMOTEREGISTRY}"
fi