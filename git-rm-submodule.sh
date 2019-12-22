#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: git-rm-submodule.sh <submodule-name>\r\n"
    printf "\r\n"
    printf "Removes the specified git submodule.  Use 'git submodule' for a list of submodules."
    printf "\r\n"
    exit 0;
fi

echo removing submodule $1

mv $1 $1_tmp

git submodule deinit -f -- $1
rm -rf .git/modules/$1
git rm -f $1
