#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]] || [[ $2 = "-help" ]] || [[ $2 = "-?" ]] || [[ $2 = "-h" ]]
then
    printf "usage: update-app.sh\r\n"
    printf "\r\n"
    printf "Creates a symlink at ~/.bam/content that targets the current app server (../../).  If there is already a symlink at ~/.bam/content it is deleted and\r\n"
    printf "replaced by a link targeting `pwd`.\r\n\r\n"
    printf "If ~/.bam/content is not a symlink but an actual directory the folder ~/.bam/content/apps/$APPNAME is deleted and replace by ./apps/$APPNAME."
    printf "\r\n"

else

APPNAME=${PWD##*/}

cd ../../

./update-app.sh $APPNAME

fi