#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: docker-debug.sh <image-name>\r\n"
    printf "\r\n"
    printf "Using docker, starts a bash prompt in the specified container to explore and debug its content."
    printf "\r\n"

else

if [[ -z "$1" ]]; then
    printf "Please specify a container."
    exit 1
fi


CONTAINER_ID=$1
COMMAND=run

if [[ $# -eq 2 ]]; then
    if [[ $1 = "container" ]]; then
        COMMAND=exec
        CONTAINER_ID=$2
    fi
    if [[ $2 = "container" ]]; then
        COMMAND=exec
        CONTAINER_ID=$1
    fi
    if [[ $1 = "image" ]]; then
        COMMAND=run
        CONTAINER_ID=$2
    fi
    if [[ $2 = "image" ]]; then
        COMMAND=run
        CONTAINER_ID=$1
    fi
fi


docker $COMMAND -p 8080:8080 -it $CONTAINER_ID bash

fi