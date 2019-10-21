#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]
then
    printf "usage: sync.sh\r\n"
    printf "\r\n"
    printf "Merge the dev branch then copy ./apps/admin/ to ./apps/bamapp/ and commit to remote."
    printf "\r\n"

else

git merge dev --quiet

cd ./apps/bamapp/
git checkout -f bamapp

cp -R ../admin/ .

git add .
git commit -m 'synced by script'
git push

cd ../../

git add .
git commit -m 'synced bamapp template'
git push

fi