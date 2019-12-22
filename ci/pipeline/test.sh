#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: test.sh <context>\r\n"
    printf "\r\n"
    printf "Call test for the specified pipeline context; the default is 'dev'.\r\n"
    if [[ -f contexts.sh ]]; then
        ./contexts.sh
    fi
    printf "\r\n"
    exit 0
fi

TESTTYPE=$1
if [[ -z $TESTTYPE ]]; then
    TESTTYPE="dev"
fi

cd ${TESTTYPE}
./test.sh $2 $3 $4 $5 $6
cd ..