#!/bin/bash

if [[ -z $IMAGEREGISTRY ]]; then
    export IMAGEREGISTRY=$(<${APPROOT}/defaultimageregistry)
    printf "login will use IMAGEREGISTRY ${IMAGEREGISTRY}"
fi

if [[ -z $REMOTEREGISTRY ]]; then
    export REMOTEREGISTRY=$(<registries/${IMAGEREGISTRY})
    printf "login will use REMOTEREGISTRY ${REMOTEREGISTRY}"
fi