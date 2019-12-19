#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]
then
    printf "usage: serve.sh\r\n"
    printf "\r\n"
    printf "serve the default section of the default application"
    printf "\r\n"
    exit 0
fi

./link-content-here.sh

APPNAME=$(<defaultappname)
SECTION=$(<apps/$APPNAME/defaultsection)

echo serving $SECTION section of $APPNAME

cd apps/$APPNAME
./serve-section.sh $SECTION

