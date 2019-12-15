#!/bin/bash

IMPL=$1
COMMAND=$2

if [[ -z $IMPL ]]; then
    IMPL="docker"
fi

if [[ -z $COMMAND ]]; then
    COMMAND="clean"
fi

source ./env.sh

printf "executing => ${IMPL}/${COMMAND}.sh\r\n"

cd ${IMPL}
./${COMMAND}.sh $3 $4 $5
cd ..