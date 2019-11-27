#!/bin/bash

docker build -t vimly-admin-debug . -f debug.Dockerfile
docker build -t vimly-admin . -f Dockerfile