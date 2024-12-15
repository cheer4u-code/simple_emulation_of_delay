#!/bin/sh

UID=`id -u`
if [ "$UID" != "0" ]; then
    echo "Please run as root."
    exit 1
fi

DELAY="120ms 10ms"
RATE_UP=3mbit
RATE_DOWN=10mbit
LOSS="random 10%"

set -x
# link1 up-link
./nsenter.sh host1  --net tc qdisc add dev eth0 root netem delay $DELAY rate $RATE_UP loss $LOSS
# link1 down-link
./nsenter.sh router --net tc qdisc add dev eth0 root netem delay $DELAY rate $RATE_DOWN loss $LOSS
# link2 up-link
./nsenter.sh host2  --net tc qdisc add dev eth0 root netem delay $DELAY rate $RATE_UP loss $LOSS
# link2 down-link
./nsenter.sh router --net tc qdisc add dev eth1 root netem delay $DELAY rate $RATE_DOWN loss $LOSS
