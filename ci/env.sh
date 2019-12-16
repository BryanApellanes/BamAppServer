#!/bin/bash

if [[ -z $APPNAME ]]; then
    export APPNAME=$(<../defaultappname)
    printf "APPNAME is ${APPNAME}\r\n"
fi

if [[ -z $IMPL ]]; then
    export IMPL=$1
fi

if [[ -z $IMPL ]]; then
    export IMPL="docker"
fi

cd ${IMPL}
source ./env.sh
cd ..

