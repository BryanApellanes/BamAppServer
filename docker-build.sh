#!/bin/bash

if [[ -z "$1" ]] || [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: docker-build .sh <image-tag> [Dockerfile]\r\n"
    printf "\r\n"
    printf "Using docker, creates a container image using the specified tag/name and optional dockerfile.\r\n"
    printf "\r\n"
    exit 0
else

TAG=$1
FILE=Dockerfile

if [[ $# -eq 2 ]]; then
    FILE=$2
fi

docker build -t $TAG . -f $FILE

fi