#!/bin/bash

if [[ -z "$1" ]] || [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]
then
    printf "usage: update-app.sh {{appName}}\r\n"
    printf "\r\n"
    printf "Update the specified bam app in (~/.bam/content/apps/{{appName}})"
    printf "by deleting ~/.bam/content/apps/{{appName}} and replacing it with"
    printf "../apps/{{appName}}."
    printf "\r\n"

else

echo removing ~/.bam/content/apps/$1
rm -fr ~/.bam/content/apps/$1

echo copying ./apps/$1 to ~/.bam/content/apps/$1
cp -R ../apps/$1 ~/.bam/content/apps/$1

fi