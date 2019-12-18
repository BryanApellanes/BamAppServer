#!/bin/bash

if [[ -z $APPROOT ]]; then
    export APPROOT="`pwd`/.."
fi

if [[ -z $APPNAME ]]; then
    export APPNAME=$(<${APPROOT}/defaultappname)
fi

if [[ -z $SEMVERROOT ]]; then
    export SEMVERROOT="${APPROOT}/semver"
fi

if [[ -z ${CONTEXT} ]]; then
    export CONTEXT=$1
fi

if [[ -z ${CONTEXT} ]]; then
    export CONTEXT="docker"
fi

if [[ -d ${CONTEXT} ]]; then
    cd ${CONTEXT}
    if [[ -f ./env.sh ]]; then
        source ./env.sh
    fi
    cd ..
fi

