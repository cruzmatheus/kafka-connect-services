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
        "connection.url": "jdbc:mysql://13.0.0.1:3306/business_condition",
        "connection.user": "root",    
        "connection.password": "example",    
        "topics": "balance",
        "auto.create": "true"  
    }
}'

curl -XPOST --header "Content-Type: application/json" ${DOCKERHOST}:8083/connectors -d '{
    "name": "campaign-trade-conditions-connector",
    "config": {
        "name": "campaign-trade-conditions-connector",
        "connector.class": "io.confluent.connect.jdbc.JdbcSinkConnector",
        "tasks.max": 1,
        "connection.url": "jdbc:mysql://13.0.0.1:3306/business_condition",
        "connection.user": "root",
        "connection.password": "example",
        "topics": "campaign-trade-conditions",
        "table.name.format": "CAMPAIGN_TRADE_CONDITIONS",
        "auto.create": "true"
    }
}'

curl -XPOST --header "Content-Type: application/json" ${DOCKERHOST}:8083/connectors -d '{
    "name": "custom-trade-condition-connector",
    "config": {
        "name": "custom-trade-condition-connector",
        "connector.class": "io.confluent.connect.jdbc.JdbcSinkConnector",
        "tasks.max": 1,
        "connection.url": "jdbc:mysql://13.0.0.1:3306/business_condition",
        "connection.user": "root",
        "connection.password": "example",
        "topics": "custom-trade-condition",
        "table.name.format": "CUSTOM_TRADE_CONDITION",
        "auto.create": "true"
    }
}'

curl -XPOST --header "Content-Type: application/json" ${DOCKERHOST}:8083/connectors -d '{
    "name": "cust-trade-conds-cost-val-connector",
    "config": {
        "name": "cust-trade-conds-cost-val-connector",
        "connector.class": "io.confluent.connect.jdbc.JdbcSinkConnector",
        "tasks.max": 1,
        "connection.url": "jdbc:mysql://13.0.0.1:3306/business_condition",
        "connection.user": "root",
        "connection.password": "example",
        "topics": "cust-trade-conds-cost-val",
        "table.name.format": "CUST_TRADE_CONDS_COST_VAL",
        "auto.create": "true"
    }
}'

curl -XPOST --header "Content-Type: application/json" ${DOCKERHOST}:8083/connectors -d '{
    "name": "transaction-cost-value-connector",
    "config": {
        "name": "transaction-cost-value-connector",
        "connector.class": "io.confluent.connect.jdbc.JdbcSinkConnector",
        "tasks.max": 1,
        "connection.url": "jdbc:mysql://13.0.0.1:3306/business_condition",
        "connection.user": "root",
        "connection.password": "example",
        "topics": "transaction-cost-value",
        "table.name.format": "TRANSACTION_COST_VALUE",
        "auto.create": "true"
    }
}'

echo ""
echo -e "\e[32mServicos iniciados\e[0m"