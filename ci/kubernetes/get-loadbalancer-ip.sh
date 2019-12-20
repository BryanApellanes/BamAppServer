#!/bin/bash

if [[ -z $1 ]] || [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: get-loadbalancer-ip.sh <app-name> [namespace]\r\n"
    printf "\r\n"
    printf "Gets the ip of the load balancer for the specified app-name.\r\n"
    printf "If no namespace is specified the value of the app-name is used.\r\n"
    printf "\r\n"
    exit 0;
fi

APPNAME=$1
NAMESPACE=$2

if [[ -z $NAMESPACE ]]; then
    NAMESPACE=$1
fi

LOADBALANCERIP=""

while [ "${LOADBALANCERIP}" == "" ] || [ "${LOADBALANCERIP}" == "null" ]
do
  SVCJSON=$(kubectl get svc -l app=${APPNAME} --namespace=${NAMESPACE} -o json) 

  LOADBALANCERIP=$(echo ${SVCJSON} | jq -r ".items[].spec.clusterIP")

  if [[ -z ${LOADBALANCERIP} ]]; then
    sleep 1.5
  fi
done
echo ${LOADBALANCERIP}