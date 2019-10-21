#!/bin/bash

cd ~/.bam
echo working dir `pwd`
echo 'deleting content...'
rm -fr content
git clone https://github.com/BryanApellanes/BamContent.git content --recurse-submodules
cd content
git checkout publish
git submodule update --init --recursive