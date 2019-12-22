#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: debug.sh container | image <image-name | container-id>\r\n"
    printf "\r\n"
    printf "Starts a bash prompt in the specified image or container to explore and debug its content."
    printf "\r\n"
    exit 0;
fi

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

docker $COMMAND -it $CONTAINER_ID bash
