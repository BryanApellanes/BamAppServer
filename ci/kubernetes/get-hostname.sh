
if [[ -z $APPNAME ]]; then
    APPNAME=$1
fi

if [[ -z $APPNAME ]]; then
    printf "\r\nPlease specify the kubernetes namespace (as the name of your application).\r\n\r\n"
    exit 1
fi

HOSTNAME=`kubectl get services -n ${APPNAME} -o json | jq '.items[0].status.loadBalancer.ingress[0].hostname'`
# trim the quotes
HOSTNAME=`echo $HOSTNAME | cut -c 2-`
HOSTNAME=${HOSTNAME%?}

echo $HOSTNAME