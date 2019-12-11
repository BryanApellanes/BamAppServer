#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: docker-debug-image.sh <container-id>\r\n"
    printf "\r\n"
    printf "Using docker, starts a container for the specified image and begins a bash prompt in that container to explore and debug its content.\r\n"
    printf "\r\n"
    exit 0;
fi

./docker-debug.sh image $1