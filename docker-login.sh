#!/bin/bash

source ./env.sh
docker login ${IMAGEREGISTRYPATH}  -u $DOCKER_USER -p $DOCKER_PASSWORD