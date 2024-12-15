#!/bin/sh

./nsenter.sh host1 --net ip route change default via 192.168.1.1
./nsenter.sh host2 --net ip route change default via 192.168.2.1
