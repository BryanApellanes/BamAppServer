#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: push.sh [azure | dockerhub | amazon] [tag]\r\n"
    printf "\r\n"
    printf "Tags and pushes the image named by the content of the file 'defaultappname'.  The image registry is specified in the \r\n"
    printf "file 'defaultimageregistry'; you may optionally specify 'azure', 'amazon' or 'dockerhub' to override the content of 'defaultimageregistry'.\r\n"
    printf "You may also specify an optional tag, the default is 'latest'.\r\n"
    printf "\r\n"
    printf "Arguments are REMOTEREGISTRY and/or TAG;\r\n"
    printf "If 1 argument is specified and is one of:\r\n\r\n"
    printf "\t'azure', 'amazon' or 'dockerhub'\r\n\r\n"
    printf "it is treated as a registry and translated to the server registry path.\r\n"
    printf "Otherwise it is treated as a tag.\r\n\r\n"
    printf "If 2 arguments are specified the second argument is treated as the tag.\r\n"
    printf "If the first argument is one of:\r\n\r\n"
    printf "\t'azure', 'amazon' or 'dockerhub'\r\n\r\n"
    printf "it is treated as a registry and translated to the server registry path.\r\n"
    printf "Otherwise it is treated as the server registry path without further translation.\r\n\r\n"
    exit 0;
fi

source ./env.sh

AZUREREGISTRY=$(<registries/azure)
DOCKERHUBREGISTRY=$(<registries/dockerhub)
AMAZONREGISTRY=$(<registries/amazon)

push () {
    printf "DOCKERIMAGEROOT is ${DOCKERIMAGEROOT}\r\n"

    if [[ -z $TAG ]]; then
        TAG="latest"
    fi

    if [[ $# = 1 ]]; then
        if [[ $1 = "azure" ]]; then
            REMOTEREGISTRY=$AZUREREGISTRY
        fi
        if [[ $1 = "amazon" ]]; then
            REMOTEREGISTRY=$AMAZONREGISTRY
        fi
        if [[ $1 = "dockerhub" ]]; then
            REMOTEREGISTRY=$DOCKERHUBREGISTRY
        else
            TAG=$1
        fi
    fi

    if [[ $# = 2 ]]; then
        TAG=$2
        if [[ $1 = "azure" ]]; then
            REMOTEREGISTRY=$AZUREREGISTRY
        fi
        if [[ $1 = "amazon" ]]; then
            REMOTEREGISTRY=$AMAZONREGISTRY
        fi
        if [[ $1 = "dockerhub" ]]; then
            REMOTEREGISTRY=$DOCKERHUBREGISTRY                
        else
            REMOTEREGISTRY=$1
        fi
    fi

    local REMOTEIMAGENAME=${REMOTEREGISTRY}/${APPNAME}:${TAG}
    printf "tagging ${APPNAME} => ${REMOTEIMAGENAME}\r\n"
    docker tag ${APPNAME} ${REMOTEIMAGENAME}
    printf "pushing ${REMOTEIMAGENAME}\r\n"
    docker push ${REMOTEIMAGENAME}
}

push $1 $2