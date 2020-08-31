#!/bin/sh

if [ -z $TARGET_IP ];
then
    echo "Error: TARGET_IP is unset. Please provide TARGET_IP via environment variable."
    exit 1
fi

if [ -z $TARGET_PORT ];
then
    echo "Error: TARGET_PORT is unset. Please provide TARGET_PORT via environment variable."
    exit 1
fi

if [ -z $FLUSH_CONNTRACK_ENDPOINT ];
then
    if [ -z $TARGET_SERVICE ];
    then
        TARGET_SERVICE="flush-conntrack"
    fi
    if [ -z $TARGET_NAMESPACE ];
    then
        TARGET_NAMESPACE="default"
    fi
    FLUSH_CONNTRACK_ENDPOINT="http://$TARGET_SERVICE.$TARGET_NAMESPACE"
fi

echo "FLUSH_CONNTRACK_ENDPOINT:$FLUSH_CONNTRACK_ENDPOINT"
echo "TARGET_IP:$TARGET_IP"
echo "TARGET_PORT:$TARGET_PORT"
curl "$FLUSH_CONNTRACK_ENDPOINT/flush?ip=$TARGET_IP&port=$TARGET_PORT"