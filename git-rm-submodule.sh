#!/bin/bash

echo removing submodule $1

mv $1 $1_tmp

git submodule deinit -f -- $1
rm -rf .git/modules/$1
git rm -f $1
