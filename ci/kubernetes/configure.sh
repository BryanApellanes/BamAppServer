#!/bin/bash
set -e

echo "*** Configuring kubectl"
kubectl config set-cluster simon365-dev --server=$KUBERNETES_SERVER --insecure-skip-tls-verify=true
kubectl config set-credentials simon365-dev --token=$KUBERNETES_TOKEN
kubectl config set-context bitbucket-pipeline-dev --cluster=simon365-dev --user=simon365-dev

# echo ${KUBERNETES_INTEGRATION_CA} | base64 -d > /tmp/simon365-integration.ca 
# kubectl config set-cluster simon365-integration --server=$KUBERNETES_INTEGRATION_SERVER --certificate-authority=/tmp/simon365-integration.ca --embed-certs=true
# kubectl config set-credentials simon365-integration --token=$KUBERNETES_INTEGRATION_TOKEN
# kubectl config set-context bitbucket-pipeline-integration --cluster=simon365-integration --user=simon365-integration

# echo ${KUBERNETES_PROD_CA} | base64 -d > /tmp/simon365-prod.ca 
# kubectl config set-cluster simon365-prod --server=$KUBERNETES_PROD_SERVER --certificate-authority=/tmp/simon365-prod.ca --embed-certs=true
# kubectl config set-credentials simon365-prod --token=$KUBERNETES_PROD_TOKEN
# kubectl config set-context bitbucket-pipeline-prod --cluster=simon365-prod --user=simon365-prod

kubectl config use-context bitbucket-pipeline-dev
kubectl version
