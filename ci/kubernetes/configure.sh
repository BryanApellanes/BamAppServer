#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: configure.sh <certificate-authority-data> <client-certificate-data> <client-key-data> <outputpath>\r\n"
    printf "\r\n"
    printf "Outputs a file 'kubeconfig' with the specified certificate data in it; then exports the variable KUBECONFIG to \r\n"
    printf "the value of the specified <outputpath>.\r\n"
    printf "\r\n"
    printf "export KUBECONFIG=<outputpath>\r\n\r\n"
    printf "If the certificate data has already been set in the environment the existing values are used, variable names are as follows:\r\n"
    printf "\tCERTAUTHORITYDATA\r\n"
    printf "\tCLIENTCERTDATA\r\n"
    printf "\tCLIENTKEYDATA\r\n"
    printf "\r\n"
    exit 0;
fi

if [[ $_ != $0 ]]; then  
  if [[ -z $CERTAUTHORITYDATA ]]; then
    CERTAUTHORITYDATA=$1
  fi

  if [[ -z $CLIENTCERTDATA ]]; then
    CLIENTCERTDATA=$2
  fi

  if [[ -z $CLIENTKEYDATA ]]; then
    CLIENTKEYDATA=$3
  fi

  if [[ -z $OUTPUTPATH ]]; then
    OUTPUTPATH=$4
  fi

  if [[ $# = 1 ]]; then
      OUTPUTPATH=$1
  fi

  if [[ -z $OUTPUTPATH ]]; then
    OUTPUTPATH="./kubeconfig"    
  fi

  if [[ -z $CERTAUTHORITYDATA ]] || [[ -z $CLIENTCERTDATA ]] || [[ -z $CLIENTKEYDATA ]]; then
    printf "Missing required certificate data\r\n"
    if [[ -z $CERTAUTHORITYDATA ]];then
      printf "\tCERTAUTHORTITYDATA was not set\r\n"
    fi
    if [[ -z $CLIENTCERTDATA ]]; then
      printf "\tCLIENTCERTDATA was not set\r\n"
    fi
    if [[ -z $CLIENTKEYDATA ]]; then
      printf "\tCLIENTKEYDATA was not set\r\n"
    fi
    printf "\r\n"
    return 1;
  fi

  echo "apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: ${CERTAUTHORITYDATA}
    server: https://api.k8s.jedan.simon365.com
  name: k8s.jedan.simon365.com
contexts:
- context:
    cluster: k8s.jedan.simon365.com
    user: k8s.jedan.simon365.com
  name: default
- context:
    cluster: ""
    user: ""
  name: defaut
current-context: default
kind: Config
preferences: {}
users:
- name: k8s.jedan.simon365.com
  user:
    client-certificate-data: ${CLIENTCERTDATA}
    client-key-data: ${CLIENTKEYDATA}
    password: LmXQ8MooqMW4vywCm40hq4YhTFutaodQ
    username: admin" > ${OUTPUTPATH}

  export KUBECONFIG=${OUTPUTPATH}
  echo "KUBECONFIG=${KUBECONFIG}"
else
  printf "\r\nPlease source this file to ensure your KUBECONFIG environment variable is properly updated.\r\n\r\n"
  printf "source ./configure.sh <outputpath>\r\n\r\n"
fi