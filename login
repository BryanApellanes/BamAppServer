#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: login <context>\r\n"
    printf "\r\n"
    printf "Call login for the specified context; the default is 'docker'.\r\n"
    printf "Possible context values are found in the ./ci directory.\r\n"
    printf "\r\n"
    exit 0
fi

CONTEXT=$1

if [[ -z $1 ]]; then
    export CONTEXT="docker"
fi

export COMMAND="login"

cd ./ci
./exec.sh ${CONTEXT} ${COMMAND} $2 $3
cd ..