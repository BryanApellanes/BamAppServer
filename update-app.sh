#!/bin/bash

if  [[ -z "$1" ]]
    then
        APPNAME=$(<defaultappname)
else
    APPNAME=$1
fi


if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]] || [[ $2 = "-help" ]] || [[ $2 = "-?" ]] || [[ $2 = "-h" ]]
then
    printf "usage: update-app.sh\r\n"
    printf "\r\n"
    printf "Creates a symlink at ~/.bam/content that targets the current directory.  If there is already a symlink at ~/.bam/content it is deleted and\r\n"
    printf "replaced by a link targeting `pwd`.\r\n\r\n"
    printf "If ~/.bam/content is not a symlink but an actual directory the folder ~/.bam/content/apps/$APPNAME is deleted and replace by ./apps/$APPNAME."
    printf "\r\n"

else

if [[ ! -f ~/.bam/content ]] || [[ -L ~/.bam/content ]]
    then
        echo "creating ~/.bam/content symlink directing to `pwd`..."
        if [[ ~/.bam/content -ef `pwd` ]]
            then
                echo "already targeting `pwd`, no action needed."
        else
            echo "removing ~/.bam/content"
            rm ~/.bam/content
            echo "linking ~/.bam/content to `pwd`"
            ln -s `pwd` ~/.bam/content
        fi
else

echo '~/.bam/content is not a symlink'

echo removing ~/.bam/content/apps/$APPNAME
rm -fr ~/.bam/content/apps/$APPNAME

echo copying ./apps/$1 to ~/.bam/content/apps/$APPNAME
cp -R ./apps/$1 ~/.bam/content/apps/$APPNAME

fi 

fi