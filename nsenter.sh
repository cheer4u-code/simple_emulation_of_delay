#!/bin/sh

if [ $# -lt 2 ]; then
    echo "Usage: $0 host prog"
    exit 1
fi
HOST=$1
shift

UID=`id -u`
if [ "$UID" != "0" ]; then
    echo "Please run as root."
    exit 1
fi

PID=`docker inspect --format {{.State.Pid}} $HOST`
if [ -z "$PID" ]; then
    echo "${HOST}: not found"
    exit 1
fi

exec nsenter --target $PID $*
