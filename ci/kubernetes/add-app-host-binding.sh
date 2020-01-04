#!/bin/bash

HOSTNAME=`kubectl get services -n ${APPNAME} -o json | jq '.items[0].status.loadBalancer.ingress[0].hostname'`
# trim the quotes
HOSTNAME=`echo $HOSTNAME | cut -c 2-`
export HOSTNAME=${HOSTNAME%?}
# / trim the quotes

CURDIR=`pwd`
cd ./node
npm install
node ./cli.js shellExecute -app:${APPNAME} -add:app-host-binding -hostName:${HOSTNAME} -content:${APPROOT}
cd $CURDIR