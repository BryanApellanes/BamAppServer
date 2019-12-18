#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: test.sh <context>\r\n"
    printf "\r\n"
    printf "Call clean for the specified context; the default is 'docker'.\r\n"
    printf "Possible context values are found in the ./ci directory.\r\n"
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