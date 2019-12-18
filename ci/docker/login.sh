#!/bin/bash

source ./env.sh

printf "IMAGEREGISTRY is ${IMAGEREGISTRY}\r\n"
cd login
./${IMAGEREGISTRY}.sh
cd ..