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

if [[ -z $IMPL ]]; then
    export IMPL=$1
fi

if [[ -z $IMPL ]]; then
    export IMPL="docker"
fi

if [[ -d ${IMPL} ]]; then
    cd ${IMPL}
    if [[ -f ./env.sh ]]; then
        source ./env.sh
    fi
    cd ..
fi

