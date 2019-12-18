#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: push <implementation> [additional arguments]\r\n"
    printf "\r\n"
    printf "Call push for the specified context; the default is 'docker'.\r\n"
    printf "Possible implementation values are found in the ./ci directory.\r\n"
    printf "\r\n"
    printf "IMPLEMENTATION HELP -- \r\n"
    ./ci/docker/push.sh -?
    exit 0
fi

CONTEXT=$1

if [[ -z $1 ]]; then
    export CONTEXT="docker"
fi

export COMMAND="push"

if [[ !(-z $2) ]]; then
    export COMMAND="push-$2"
fi

REGISTRYALIASORPATH=$3

if [[ -z $REGISTRYALIASORPATH ]]; then
    export REGISTRYALIASORPATH=$(<defaultimageregistry)
fi

printf "REGISTRYALIASORPATH is ${REGISTRYALIASORPATH}\r\n"
cd ./ci
./exec.sh ${CONTEXT} ${COMMAND} ${REGISTRYALIASORPATH}
cd ..
