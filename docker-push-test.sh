#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: docker-push-test.sh [azure | amazon | dockerhub]\r\n"
    printf "\r\n"
    printf "Tags the image named by the content of the file 'defaultappname' as 'test' and pushes to the specified or default registry.  The image registry is specified in the \r\n"
    printf "file 'defaultimageregistry'; you may optionally specify 'azure', amazon or 'dockerhub' to override the content of 'defaultimageregistry'"
    printf "\r\n"
    exit 0;
fi

IMAGEREGISTRY=$1
COMMIT=$(git log --format="%H" -n 1 | cut -c 1-6)
./docker-push.sh ${IMAGEREGISTRY} "test"
./docker-push.sh ${IMAGEREGISTRY} "test-${COMMIT}"
./docker-push.sh ${IMAGEREGISTRY} ${COMMIT}