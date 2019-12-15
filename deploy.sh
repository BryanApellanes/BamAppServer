#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: deploy.sh [test | staging | release]\r\n"
    printf "\r\n"
    printf "Deploy the project to the test or release environment."
    printf "\r\n"
    exit 0;
fi

if [[ $1 = "test" ]]; then
    echo "TODO: add test deploy code here"
    exit $?
fi

if [[ $1 = "release" ]]; then
    echo "TODO: add release deploy code here"
    
    exit $?
fi

if [[ $# = 1 ]]; then
    IMAGEREGISTRY=$(<defaultimageregistry)
    COMMIT=$1

    echo "TODO: implement manual deploy of specific commit"
fi