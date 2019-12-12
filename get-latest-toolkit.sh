#!/bin/bash

cd Workspace/BamToolkit
git fetch --all
git submodule update --init --recursive
git checkout -f BamToolkit
git pull --recurse-submodules