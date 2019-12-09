#!/bin/bash

APPNAME=$(<defaultappname)
docker build -t ${APPNAME}-debug . -f debug.Dockerfile
docker build -t ${APPNAME} . -f Dockerfile