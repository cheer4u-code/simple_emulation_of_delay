#!/bin/sh

UID=`id -u`
if [ "$UID" != "0" ]; then
    echo "Please run as root."
    exit 1
fi

DELAY=120ms
RATE_UP=3mbit
RATE_DOWN=10mbit

set -x
# link1 up-link
./nsenter.sh host1  --net tc qdisc show dev eth0
# link1 down-link
./nsenter.sh router --net tc qdisc show dev eth0
# link2 up-link
./nsenter.sh host2  --net tc qdisc show dev eth0
# link2 down-link
./nsenter.sh router --net tc qdisc show dev eth0
