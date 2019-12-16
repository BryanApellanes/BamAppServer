#!/bin/bash

if [[ -z $DOCKERIMAGEROOT ]]; then
    export DOCKERIMAGEROOT="`pwd`/../../"
fi

if [[ -z $APPNAME ]]; then
    export APPNAME=$(<${DOCKERIMAGEROOT}defaultappname)
fi

if [[ -z $DOCKERFILE ]]; then
    export DOCKERFILE="`pwd`/Dockerfile"
fi

if [[ -z $DEBUGDOCKERFILE ]]; then
    export DEBUGDOCKERFILE="`pwd`/debug.Dockerfile"
fi 

if [[ -z $SEMVERROOT ]]; then
    export SEMVERROOT="${DOCKERIMAGEROOT}semver/"
fi

if [[ -z $IMAGEREGISTRY ]]; then
    export IMAGEREGISTRY=$(<${DOCKERIMAGEROOT}defaultimageregistry)
fi

if [[ -z $REMOTEREGISTRY ]]; then
    export REMOTEREGISTRY=$(<registries/${IMAGEREGISTRY})
fi

if [[ -z $TAG ]]; then
    export TAG=$(<${SEMVERROOT}version)
fi

printf "DOCKERIMAGEROOT is ${DOCKERIMAGEROOT}\r\n"
printf "DOCKERFILE is ${DOCKERFILE}\r\n"
printf "DEBUGDOCKERFILE is ${DEBUGDOCKERFILE}\r\n"
printf "SEMVERROOT is ${SEMVERROOT}\r\n"