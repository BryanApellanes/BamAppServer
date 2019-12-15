#!/bin/bash

if [[ -z $DOCKERIMAGEROOT ]]; then
    export DOCKERIMAGEROOT="`pwd`/../../"
fi

if [[ -z $DOCKERFILE ]]; then
    export DOCKERFILE="`pwd`/Dockerfile"
fi

if [[ -z $DEBUGDOCKERFILE ]]; then
    export DEBUGDOCKERFILE="`pwd`/debug.Dockerfile"
fi 

printf "DOCKERIMAGEROOT is ${DOCKERIMAGEROOT}\r\n"
printf "DOCKERFILE is ${DOCKERFILE}\r\n"
printf "DEBUGDOCKERFILE is ${DEBUGDOCKERFILE}\r\n"