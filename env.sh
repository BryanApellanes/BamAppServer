#!/bin/bash

export IMAGEREGISTRY=$(<defaultimageregistry)
export IMAGEREGISTRYPATH=$(<imageregistries/${IMAGEREGISTRY})
export DOCKER_USER=`head -1 ./imageregistries/creds/${IMAGEREGISTRY} | tail -1`
export DOCKER_PASSWORD=`head -2 ./imageregistries/creds/${IMAGEREGISTRY} | tail -1`
