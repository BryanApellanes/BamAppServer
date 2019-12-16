#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: login <implementation>\r\n"
    printf "\r\n"
    printf "Call login for the specified implementation flow; the default is 'docker'.\r\n"
    printf "Possible implementation values are found in the ./ci directory.\r\n"
    printf "\r\n"
    exit 0
fi

IMPL=$1

if [[ -z $1 ]]; then
    export IMPL="docker"
fi

export COMMAND="login"

cd ./ci
./exec.sh ${IMPL} ${COMMAND} $2 $3
cd ..