#!/bin/bash

git submodule update --init --recursive

cd Workspace/BamToolkit/
source ./setup.sh

cd ../../
npm install