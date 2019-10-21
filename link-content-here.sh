#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]
then
    printf "usage: link.sh\r\n"
    printf "\r\n"
    printf "Create a symlink at ~/.bam/content that targets the current directory.  If there is already a symlink at ~/.bam/content it is deleted and\r\n"
    printf "replaced by a link targeting `pwd`.\r\n\r\n"
    printf "If ~/.bam/content is not a symlink but an actual directory no action is taken.  If ~/.bam/content is a symlink that targets `pwd` no action is taken."
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

fi 

fi
