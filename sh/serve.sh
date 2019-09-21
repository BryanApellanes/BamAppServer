#!/bin/bash

if [ -z "$1" ] || [ $1 = "-help" ] || [ $1 = "-?" ] || [ $1 = "-h" ]
then
    printf "usage: serve.sh {appName}\r\n"
    printf "\r\n"
    printf "Serve the specified application."
    printf "\r\n"

else

PROJECTNAME=$1

source ./get-os-runtime.sh

echo Runtime is set to $RUNTIME

dotnet ~/.bam/toolkit/$RUNTIME/$PROJECTNAME/$PROJECTNAME.dll $2 $3 $4 $5

fi