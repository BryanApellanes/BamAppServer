#!/bin/bash

APPNAME=$(<defaultappname)
REMOTEREGISTRY=$(<defaultdockerregistry)
REMOTEIMAGENAME=${REMOTEREGISTRY}${APPNAME}:latest

docker tag ${APPNAME} ${REMOTEIMAGENAME}
docker push ${REMOTEIMAGENAME}