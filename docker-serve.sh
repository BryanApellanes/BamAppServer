#!/bin/bash


if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: docker-serve.sh\r\n"
    printf "\r\n"
    printf "Using docker, starts a a containter using the image referenced by the content of the file 'defaultappname'.\r\n"
    printf "This assumes that the image has already been built and is available.\r\n"
    printf "\r\n"
    exit 0
else

SUFFIX=`date | md5`
NAME=$(<defaultappname)
IMAGE=$(<defaultappname)
PORTS=$(<defaultports)

docker run -d -p $PORTS --name $NAME-$SUFFIX $IMAGE

fi