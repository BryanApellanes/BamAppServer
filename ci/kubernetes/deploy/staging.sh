#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: staging.sh\r\n"
    printf "\r\n"
    printf "Deploy the project to the staging environment."
    printf "\r\n"
    exit 0;
fi

if [[ -z ${IMAGETAG} ]]; then
    IMAGETAG=$1
fi

DEPLOYCONTEXT=staging
DEPLOYNAMESPACE=staging

echo "Current context is ${PWD##*/}"
echo "IMAGETAG = ${IMAGETAG}"
echo "Running KUBERNETES '${DEPLOYCONTEXT}' deployment."

if [[ -f ../configs/${APPNAME}-${DEPLOYCONTEXT}-deployment.yml ]]; then
    echo "../configs/${APPNAME}-${DEPLOYCONTEXT}-deployment.yml exists"
    kubectl config use-context bitbucket-pipeline-staging
    kubectl version 
    kubectl apply -f ../configs/${APPNAME}-${DEPLOYCONTEXT}-deployment.yml
    ../verify.sh ${APPNAME} ${DEPLOYNAMESPACE}
else
    echo "../configs/${APPNAME}-${DEPLOYCONTEXT}-deployment.yml DOES NOT exist"
fi