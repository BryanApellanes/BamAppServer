#!/bin/bash

echo "*** Configuring kubectl"
echo "*** Server is ${KUBERNETES_SERVER}"
kubectl config set-cluster simon365-test --server=${KUBERNETES_SERVER} --insecure-skip-tls-verify=true
kubectl config set-credentials simon365-test --token=${KUBERNETES_TOKEN}
kubectl config set-context bitbucket-pipeline-test --cluster=simon365-dev --user=simon365-test

kubectl config use-context bitbucket-pipeline-test
kubectl version
