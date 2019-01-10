Kafka Connect
===================

Project to export data from Kafka topic to a database.


Running locally
---------------------

To start or stop kafka connect locally, just run the files **start.sh/stop.sh**. Place the MySQL JDBC driver in `/tmp/kafka-connect-example/jars`


Testing messasge consumer
-----------------------------

Run the command bellow to send Avro messages to the **users** topic.

    docker exec -it kafka-connect kafka-avro-console-producer --broker-list localhost:9092 --topic users --property value.schema='{"type":"record","name":"Test","fields":[{"name":"id","type":"long"},{"name": "name","type": "string"}]}'

Send the messages bellow, to the **users** topic.

    {"id": 1, "name": "John"}
    {"id": 2, "name": "Trisha"}
    {"id": 3, "name": "Bruce"}

The output bellow is the expected database results, extracted from **users** topic.

    mysql> select * from USERS;
    +----------------+
    | ID | NAME      |
    +----------------+
    | 1        Jonh  |
    | 2        Trisha|
    | 3        Bruce |
    +----------------+


Kafka Connect UI e Topic UI
-----------------------------

It is possible to check and manage Kafka connectors, by accessing the url http://localhost:8001

Topics may be viewed at http://localhost:8000