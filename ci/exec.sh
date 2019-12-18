#!/bin/bash

export CONTEXT=$1
export COMMAND=$2

if [[ -z ${CONTEXT} ]]; then
    export CONTEXT="docker"
fi

if [[ -z $COMMAND ]]; then
    export COMMAND="clean"
fi

source ./env.sh

printf "executing => ${CONTEXT}/${COMMAND}.sh $3 $4 $5\r\n"

if [[ !(-d ${CONTEXT}) ]]; then
    printf "\r\n"
    printf "`pwd`/${CONTEXT} folder doesn't exist.\r\n"
    printf "The command '${COMMAND}' cannot be run for the specified context '${CONTEXT}''.\r\n"
    printf "\r\n"
    exit 1
fi

cd ${CONTEXT}
./${COMMAND}.sh $3 $4 $5 $6
cd ..