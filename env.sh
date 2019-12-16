#!/bin/bash

export IMAGEREGISTRY=$(<defaultimageregistry)
export IMAGEREGISTRYPATH=$(<ci/docker/login/${IMAGEREGISTRY})
export DOCKER_USER=`head -1 ./imageregistries/creds/${IMAGEREGISTRY} | tail -1`
export DOCKER_PASSWORD=`head -2 ./imageregistries/creds/${IMAGEREGISTRY} | tail -1`
