#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: deploy.sh [test | staging | release]\r\n"
    printf "\r\n"
    printf "Deploy the project to the test or release environment."
    printf "\r\n"
    exit 0;
fi

if [[ -z $1 ]]; then 
    if [[ -z $TARGETENVIRONMENT ]]; then
        export TARGETENVIRONMENT="test"
    fi
else
    export TARGETENVIRONMENT=$1
fi

printf "TARGETENVIRONMENT is ${TARGETENVIRONMENT}\r\n"
printf "CURDIR is `pwd`\r\n"

cd deploy
./${TARGETENVIRONMENT}.sh
cd ..
