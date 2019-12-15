#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: clean.sh <image-name>\r\n"
    printf "\r\n"
    printf "Using docker, deletes exited containers and dangling images."
    printf "\r\n"
    exit 0
fi

CONTAINERS=$(docker ps -q -f 'status=exited')
if [[ !(-z $CONTAINERS) ]]; then
    printf "executing => 'docker rm $(docker ps -q -f 'status=exited')'\r\n"
    docker rm ${CONTAINERS}
else
    printf "No containers to remove\r\n"
fi

IMAGES=$(docker images -q -f "dangling=true")
if [[ !(-z $IMAGES) ]]; then
    printf "executing => 'docker rmi $(docker images -q -f "dangling=true")'\r\n"
    docker rmi ${IMAGES}    
else
    printf "No images to remove\r\n"
fi

