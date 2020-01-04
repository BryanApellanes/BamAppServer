#!/bin/bash

CURDIR=`pwd`
cd ../../ci/kubernetes
./add-app-host-binding.sh
cd $CURDIR