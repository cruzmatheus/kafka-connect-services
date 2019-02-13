#! /bin/bash

export DOCKERHOST=$(ifconfig | grep -E "([0-9]{1,3}\.){3}[0-9]{1,3}" | grep -v 127.0.0.1 | awk '{ print $2 }' | cut -f2 -d: | head -n1)

docker-compose up -d --force-recreate &

# time=40
# echo -e "\e[32mAguardando ${time}s para a subida dos servicos\e[0m"
# sleep $time

curl -XPOST --header "Content-Type: application/json" ${DOCKERHOST}:8083/connectors -d '{  
    "name": "sink",  
    "config": {    
        "name": "sink",    
        "connector.class": "io.confluent.connect.jdbc.JdbcSinkConnector",    
        "tasks.max": 1,    
        "connection.url": "jdbc:mysql://13.0.0.1:3306/example",
        "connection.user": "root",    
        "connection.password": "example",    
        "topics": "balance",
        "auto.create": "true"  
    }
}'

echo ""
echo -e "\e[32mServicos iniciados\e[0m"
