#! /bin/bash

export DOCKERHOST=$(ifconfig | grep -E "([0-9]{1,3}\.){3}[0-9]{1,3}" | grep -v 127.0.0.1 | awk '{ print $2 }' | cut -f2 -d: | head -n1)

docker-compose down

time=5
sleep $time

echo -e "\e[32mThe services were stopped\e[0m"
