#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: debug-image.sh <container-id>\r\n"
    printf "\r\n"
    printf "Starts a container for the specified image and begins a bash prompt in that container to explore and debug its content.\r\n"
    printf "Use 'docker images' to view available images."
    printf "\r\n"
    exit 0;
fi

./debug.sh image $1