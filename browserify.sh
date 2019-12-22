#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]
then
    printf "usage: browserify.sh\r\n"
    printf "\r\n"
    printf "browserify the default section of the default application"
    printf "\r\n"

else

APPNAME=$(<defaultappname)
SECTION=$(<apps/$APPNAME/defaultsection)

echo browserify $SECTION section of $APPNAME

cd apps/$APPNAME
./browserify.sh $SECTION

fi
