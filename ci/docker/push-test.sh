#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: push-test.sh [azure | amazon | dockerhub]\r\n"
    printf "\r\n"
    printf "Tags the image named by the content of the file 'defaultappname' as 'test' and pushes to the specified or default registry.  The image registry is specified in the \r\n"
    printf "file 'defaultimageregistry'; you may optionally specify 'azure', amazon or 'dockerhub' to override the content of 'defaultimageregistry'"
    printf "\r\n"
    exit 0;
fi

source ./env.sh

if [[ !(-z $1) ]]; then
    export IMAGEREGISTRY=$1
    printf "using image registry ${IMAGEREGISTRY}\r\n"
    export REMOTEREGISTRY=$(<registries/${IMAGEREGISTRY})
    printf "using remote registry ${REMOTEREGISTRY}\r\n"
fi

if [[ -z $IMAGEREGISTRY ]]; then
    export IMAGEREGISTRY=$(<${APPROOT}/defaultimageregistry)
    printf "using default image registry ${IMAGEREGISTRY}\r\n"
fi

if [[ -z $REMOTEREGISTRY ]]; then
    export REMOTEREGISTRY=$(<registries/${IMAGEREGISTRY})
    printf "using remote registry ${REMOTEREGISTRY}\r\n"
fi

printf "REMOTEREGISTRY is ${REMOTEREGISTRY}\r\n"
COMMIT=$(git log --format="%H" -n 1 | cut -c 1-6)
./push.sh ${REMOTEREGISTRY} "test"
./push.sh ${REMOTEREGISTRY} "test-${COMMIT}"
./push.sh ${REMOTEREGISTRY} ${COMMIT}