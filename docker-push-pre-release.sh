#!/bin/bash


if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: docker-push-release.sh [azure | amazon | dockerhub]\r\n"
    printf "\r\n"
    printf "Tags the image named by the content of the file 'defaultappname' with the pre-release version and pushes to the specified or default registry.  The image registry is specified in the \r\n"
    printf "file 'defaultimageregistry'; you may optionally specify 'azure', 'amzon' or 'dockerhub' to override the content of 'defaultimageregistry'."
    printf "\r\n"
    exit 0;
fi

./docker-version.sh 