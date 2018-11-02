#!/bin/bash

#sudo service elasticsearch start 
#sudo service kibana start
/home/docker/kafka/kafka_2.11-2.0.0/bin/zookeeper-server-start.sh -daemon /home/docker/kafka/kafka_2.11-2.0.0/config/zookeeper.properties
/home/docker/kafka/kafka_2.11-2.0.0/bin/kafka-server-start.sh -daemon /home/docker/kafka/kafka_2.11-2.0.0/config/server.properties
bash
