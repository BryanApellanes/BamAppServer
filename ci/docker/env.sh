#!/bin/bash

if [[ -z $APPROOT ]]; then
    export APPROOT="`pwd`/../.."
fi

if [[ -z $APPNAME ]]; then
    export APPNAME=$(<${APPROOT}/defaultappname)
fi

if [[ -z $SEMVERROOT ]]; then
    export SEMVERROOT="${APPROOT}/semver"
fi

if [[ -z $DOCKERFILE ]]; then
    export DOCKERFILE="${APPROOT}/Dockerfile"
fi

if [[ -z $DEBUGDOCKERFILE ]]; then
    export DEBUGDOCKERFILE="${APPROOT}/debug.Dockerfile"
fi 

if [[ -z $IMAGEREGISTRY ]]; then
    export IMAGEREGISTRY=$(<${APPROOT}/defaultimageregistry)
fi

if [[ -z $REMOTEREGISTRY ]]; then
    if [[ $IMAGEREGISTRY = "amazon" ]]; then 
        IMAGEREPOSITORY=$(aws ecr get-login --no-include-email | sed 's|.*https://||')
        echo "setting image registry: echo $IMAGEREPOSITORY > registries/${IMAGEREGISTRY}"
        echo $IMAGEREPOSITORY > registries/${IMAGEREGISTRY}
        echo "attempting to create amazon ecr repository if it doesn't exist: ${APPNAME}"
        aws ecr describe-repositories --repository-names ${APPNAME} || aws ecr create-repository --repository-name ${APPNAME}
    fi
    export REMOTEREGISTRY=$(<registries/${IMAGEREGISTRY})    
fi

if [[ -z $TAG ]]; then
    export TAG=$(<${SEMVERROOT}/version)
fi

printf "APPROOT is ${APPROOT}\r\n"
printf "APPNAME is ${APPNAME}\r\n"
printf "DOCKERFILE is ${DOCKERFILE}\r\n"
printf "DEBUGDOCKERFILE is ${DEBUGDOCKERFILE}\r\n"
printf "SEMVERROOT is ${SEMVERROOT}\r\n"
printf "IMAGEREGISTRY is ${IMAGEREGISTRY}\r\n"
printf "REMOTEREGISTRY is ${REMOTEREGISTRY}\r\n"