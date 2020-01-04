HOSTNAME=`kubectl get services -n ${APPNAME} -o json | jq '.items[0].status.loadBalancer.ingress[0].hostname'`
# trim the quotes
HOSTNAME=`echo $HOSTNAME | cut -c 2-`
HOSTNAME=${HOSTNAME%?}

echo $HOSTNAME