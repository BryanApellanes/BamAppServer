#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: verify <app-name> <namespace>\r\n"
    printf "\r\n"
    printf "Verifies that kubernetes pods started successfully.\r\n"
    printf "\r\n"
    exit 0;
fi

APP=$1
NAMESPACE=$2
REPLICAS_REQUIRED=$(kubectl get deployment --namespace ${NAMESPACE} ${APP} -o json | jq -r .status.replicas)
START_TIMESTAMP=$(date +%s)
MAX_TIME=90

echo "==================================================================================================="
echo " Verifing Kubernetes Deployment:"
echo "    Namespace: ${NAMESPACE}"
echo "    App:       ${APP}"
echo "    Timeout:   ${MAX_TIME}"
echo "    Expented Replicas: ${REPLICAS_REQUIRED}"
echo "==================================================================================================="
echo $(date) "**** Probe started."

kubectl get pods -n ${NAMESPACE} -l app=${APP} -o wide | head -1
while true; do
    kubectl get pods -n ${NAMESPACE} -l app=${APP} -o wide | sed '1d'
    DEPLOYMENT_UID=$(kubectl get deployment -n ${NAMESPACE} ${APP} -o json | jq -r .metadata.uid)
    REPLICASET_UID=$(kubectl get rs -n ${NAMESPACE} -l app=${APP} -o json | jq -r '.items[] | select( .metadata.ownerReferences[].uid == "'${DEPLOYMENT_UID}'") | .metadata.uid' | head -1)
    REPLICAS_READY=$(kubectl get deployment --namespace ${NAMESPACE} ${APP} -o json | jq -r '.status.readyReplicas + 0')

    if [ ${REPLICAS_READY} -ge ${REPLICAS_REQUIRED} ]; then
        echo ""
        echo $(date) "**** Service ready."
        exit 0
    fi

    if [ ! -z "$(kubectl get pods -n ${NAMESPACE} -l app=${APP} -o json | jq -r '.items[] | select( .metadata.ownerReferences[].uid == "'${REPLICASET_UID}'") | .status.phase' | egrep -e '(Error|CrashLoopBackOff|ImagePullBackOff)')" ]; then
        kubectl get pods -n ${NAMESPACE} -l app=${APP} -o json | jq -r '.items[] | select( .metadata.ownerReferences[].uid == "'${REPLICASET_UID}'") | .status.phase'
        kubectl get pods -n ${NAMESPACE} -l app=${APP} -o wide | sed '1d'
        echo "FAILURE: Pods are in error or crash backoff loop status, not able to start"
        exit -1
    fi

    if [ ! -z "$(kubectl get pods -n ${NAMESPACE} -l app=${APP} -o json | jq -r '.items[] | select( .metadata.ownerReferences[].uid == "'${REPLICASET_UID}'") | .status.containerStatuses[].state[].reason' | egrep -e '(ImagePullBackOff|ErrImagePull)')" ]; then
        kubectl get pods -n ${NAMESPACE} -l app=${APP} -o wide | sed '1d'
        echo "FAILURE: Pods are in error or crash backoff loop status, not able to start"
        exit -1
    fi

    CURRENT_TIMESTAMP=$(date +%s)
    if [[ $((${START_TIMESTAMP}+${MAX_TIME})) -le ${CURRENT_TIMESTAMP} ]]; then
        echo "Timed out (${MAX_TIME} seconds) waiting for pods to start."
        exit -1
    fi
    sleep 1
done


