#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: test.sh\r\n"
    printf "\r\n"
    printf "Deploy the project to the test environment."
    printf "\r\n"
    exit 0;
fi

if [[ -z ${IMAGETAG} ]]; then
    IMAGETAG=$1
fi

DEPLOYCONTEXT=test
DEPLOYMENTFILE=../configs/${APPNAME}-${DEPLOYCONTEXT}-deployment.yml
SERVICEFILE=../configs/${APPNAME}-service.yml
KUBECONFIG=~/.kube/ci-${DEPLOYCONTEXT}-config

if [[ !(-f $DEPLOYMENTFILE) ]]; then
    echo "Kubernetes deployment file ${DEPLOYMENTFILE} does not exist\r\n"
    return 1;
fi

if [[ !(-f SERVICEFILE) ]]; then
    echo "Kubernetes service file ${SERVICEFILE} does not exist\r\n"
    return 1;
fi

echo "Current context is ${PWD##*/}"
echo "IMAGETAG = ${IMAGETAG}"

echo "Writing kubernetes config ${KUBECONFIG}...\r\n"
source ../../kubernetes/configure.sh $KUBECONFIG
echo "Wrote kubernetes config ${KUBECONFIG}.\r\n"
echo "KUBECONFIG=$KUBECONFIG"

echo "Running KUBERNETES '${DEPLOYCONTEXT}' deployment."

echo "Applying kubernetes deployment file ${DEPLOYMENTFILE}\r\n"
kubectl apply -f ${DEPLOYMENTFILE}

echo "Applying kubernetes service file ${SERVICEFILE}\r\n"
kubectl apply -f ${SERVICEFILE}