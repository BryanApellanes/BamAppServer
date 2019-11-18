#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: debug-container.sh <container-id>\r\n"
    printf "\r\n"
    printf "Using docker, starts a bash prompt in the specified container to explore and debug its content."
    printf "\r\n"

else

if [[ -z "$1" ]]; then
    printf "Please specify a container."
    exit 1
fi

CONTAINER_ID=$1

docker run -it $CONTAINER_ID bash

fi