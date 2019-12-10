#!/bin/bash


if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: docker-run.sh <image-name> <image-id> <innerport>:<outerport>\r\n"
    printf "\r\n"
    printf "Using docker, starts a bash prompt in the specified container to explore and debug its content.\r\n"
    printf "\r\n"
    exit 0
else

SUFFIX=`date | md5`
NAME=$(<defaultappname)
IMAGE=$(<defaultappname)
PORTS=8080:8080

docker run -d -p $PORTS --name $NAME-$SUFFIX $IMAGE

fi