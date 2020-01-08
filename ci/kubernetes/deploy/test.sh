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
DEPLOYMENTFILE=`pwd`/../configs/${APPNAME}-${DEPLOYCONTEXT}-deployment.yml
SERVICEFILE=`pwd`/../configs/${APPNAME}-service.yml
KUBECONFIG=~/.kube/ci-${DEPLOYCONTEXT}-config

mkdir -p ~/.kube

if [[ !(-f ${DEPLOYMENTFILE}) ]]; then
    printf "Kubernetes deployment file ${DEPLOYMENTFILE} does not exist\r\n"
    exit 1;
fi

if [[ !(-f ${SERVICEFILE}) ]]; then
    printf "Kubernetes service file ${SERVICEFILE} does not exist\r\n"
    exit 1;
fi

printf "Current context is ${PWD##*/}"
printf "IMAGETAG = ${IMAGETAG}"
printf "APPROOT is ${APPROOT}"

printf "Writing kubernetes config ${KUBECONFIG}...\r\n"
source ../../kubernetes/configure.sh $KUBECONFIG
printf "Wrote kubernetes config ${KUBECONFIG}.\r\n"
printf "KUBECONFIG=$KUBECONFIG"

printf "Running KUBERNETES '${DEPLOYCONTEXT}' deployment."

printf "Applying kubernetes deployment file ${DEPLOYMENTFILE}\r\n"
kubectl apply -f ${DEPLOYMENTFILE}

printf "Applying kubernetes service file ${SERVICEFILE}\r\n"
kubectl apply -f ${SERVICEFILE}

sleep 3

HOSTNAME=`../../kubernetes/get-hostname.sh`
printf "\r\n${APPNAME} hostname is: ${HOSTNAME}\r\n"

printf "\r\n${APPNAME} load balancer ip is: "
../../kubernetes/get-loadbalancer-ip.sh ${APPNAME}
printf "\r\nHowever that is uninteresting; see below..."
DIG=`which dig`
if [[ -z $DIG ]]; then
    printf "'dig' not found; use the following command to determine ip address(es) for ${APPNAME}\r\n\r\n"
    printf "\tdig ${HOSTNAME}\r\n\r\n"
else
    dig $HOSTNAME
fi
