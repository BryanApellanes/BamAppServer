#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: docker-debug-container.sh <container-id>\r\n"
    printf "\r\n"
    printf "Using docker, starts a bash prompt in the specified container to explore and debug its content.\r\n"
    printf "Use 'docker ps' to view running containers.\r\n"
    printf "\r\n"
    exit 0;
fi

./docker-debug.sh container $1