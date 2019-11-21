#!/bin/bash

if [[ -z "$1" ]] || [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: docker-build .sh <image-name>\r\n"
    printf "\r\n"
    printf "Using docker, starts a bash prompt in the specified container to explore and debug its content.\r\n"
    printf "\r\n"
    exit 0
else

docker build -t $1 .

fi