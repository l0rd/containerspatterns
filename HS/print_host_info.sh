#!/bin/bash

HOST_IP=$(ip a s eth0 | grep "inet " | cut -d " " -f 6 | cut -d "/" -f 1 )
echo "Host IP is ${HOST_IP}"

HOST_HOSTNAME=$(hostname)
echo "Host hostname is $HOST_HOSTNAME"

echo "Host filesystem info:"
df -k /hostfs/