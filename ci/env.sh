#!/bin/bash

if [[ -z $APPNAME ]]; then
    export APPNAME=$(<../defaultappname)
fi
printf "APPNAME is ${APPNAME}\r\n"

IMPL=$1

if [[ -z $IMPL ]]; then
    IMPL="docker"
fi

cd ${IMPL}
source ./env.sh
cd ..

