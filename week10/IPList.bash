#!/bin/bash

#List all ips in the given network prefix
#/24 only

#Usage bash IPList.bash 10.0.17

[ $# -lt 1 ] &&  echo "Usage: $0 <Prefix>" && exit 1

prefix=$1

[ ${#prefix} -le 5 ] && \
printf "Prefix length is too short\nPrefix example: 10.0.17\n" && \
exit 1


for i in {1..254}
do
	echo $prefix'.'$i
done

