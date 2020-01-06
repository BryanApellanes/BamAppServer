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
    echo "Kubernetes deployment file ${DEPLOYMENTFILE} does not exist\r\n"
    exit 1;
fi

if [[ !(-f ${SERVICEFILE}) ]]; then
    echo "Kubernetes service file ${SERVICEFILE} does not exist\r\n"
    exit 1;
fi

echo "Current context is ${PWD##*/}"
echo "IMAGETAG = ${IMAGETAG}"
echo "APPROOT is ${APPROOT}"

echo "Writing kubernetes config ${KUBECONFIG}...\r\n"
source ../../kubernetes/configure.sh $KUBECONFIG
echo "Wrote kubernetes config ${KUBECONFIG}.\r\n"
echo "KUBECONFIG=$KUBECONFIG"

echo "Running KUBERNETES '${DEPLOYCONTEXT}' deployment."

echo "Applying kubernetes deployment file ${DEPLOYMENTFILE}\r\n"
kubectl apply -f ${DEPLOYMENTFILE}

echo "Applying kubernetes service file ${SERVICEFILE}\r\n"
kubectl apply -f ${SERVICEFILE}

sleep 3

HOSTNAME=`../../kubernetes/get-hostname.sh`
echo "\r\n${APPNAME} hostname is: "
$HOSTNAME
echo "\rn"

echo "\r\n${APPNAME} load balancer ip is: "
../../kubernetes/get-loadbalancer-ip.sh
echo "\r\nHowever that is uninteresting; see below..."
DIG=`which dig`
if [[ -z $DIG ]]; then
    echo "'dig' not found; use the following command to determine ip address(es) for ${APPNAME}\r\n\r\n"
    echo "\tdig ${HOSTNAME}\r\n\r\n"
else
    dig $HOSTNAME
fi
