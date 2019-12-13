#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: docker-push.sh [azure | dockerhub] [tag]\r\n"
    printf "\r\n"
    printf "Tags and pushes the image named by the content of the file 'defaultappname'.  The image registry is specified in the \r\n"
    printf "file 'defaultimageregistry'; you may optionally specify 'azure', 'amazon' or 'dockerhub' to override the content of 'defaultimageregistry'.\r\n"
    printf "You may also specify an optional tag, the default is 'latest'.\r\n"
    printf "\r\n"
    exit 0;
fi

AZUREREGISTRY=$(<imageregistries/azure)
DOCKERHUBREGISTRY=$(<imageregistries/dockerhub)
AMAZONREGISTRY=$(<imageregistries/amazon)

push () {
    local APPNAME=$(<defaultappname)
    local REMOTEREGISTRY=$(<defaultimageregistry)
    local TAG=$(<version)

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
    printf "pushing ${REMOTEIMAGENAME}"
    docker push ${REMOTEIMAGENAME}
}

push $1 $2