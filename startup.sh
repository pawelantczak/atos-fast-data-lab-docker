#!/bin/bash

# Config
export spring_security_user_name=u
export spring_security_user_password=p
export spring_autoconfigure_exclude=org.springframework.boot.autoconfigure.security.SecurityAutoConfiguration
export spring_cloud_dataflow_metrics_collector_uri=http://localhost:9494
export spring_cloud_dataflow_applicationProperties_stream_spring_cloud_stream_bindings_applicationMetrics_destination=metrics
export spring_cloud_dataflow_applicationProperties_stream_spring_metrics_export_includes=integration.channel.input**,integration.channel.output**
export spring_cloud_dataflow_metrics_collector_username=u 
export spring_cloud_dataflow_metrics_collector_password=p
export KAFKA_HEAP_OPTS="-Xmx512M -Xms512M"

echo "Starting ELK"
sudo service elasticsearch start
sudo service kibana start

echo "Starting Kafka"
/home/atos/kafka/kafka_2.11-2.0.0/bin/zookeeper-server-start.sh -daemon /home/atos/kafka/kafka_2.11-2.0.0/config/zookeeper.properties
/home/atos/kafka/kafka_2.11-2.0.0/bin/kafka-server-start.sh -daemon /home/atos/kafka/kafka_2.11-2.0.0/config/server.properties

echo "Starting Spring CDF"
nohup java -Xmx512m -jar /home/atos/scdf/spring-cloud-dataflow-server-local-1.7.0.RELEASE.jar --logging.file=/home/atos/scdf/scdf.log --spring.cloud.dataflow.applicationProperties.stream.spring.cloud.stream.bindings.applicationMetrics.destination=metrics --spring.cloud.dataflow.applicationProperties.stream.spring.metrics.export.includes=integration.channel.input**,integration.channel.output** --spring.cloud.dataflow.applicationProperties.deployer.*.memory=64m >/dev/null 2>&1 &
nohup java -Xmx64m -jar /home/atos/scdf/metrics-collector-kafka-2.0.0.RELEASE.jar --logging.file=/home/atos/scdf/collector.log --server.port=9494 >/dev/null 2>&1 &
until $(curl --output /dev/null --silent --fail http://localhost:9393); do printf '.'; sleep 1; done
echo -e "\nSetting-up Spring CDF"
java -jar /home/atos/scdf/spring-cloud-dataflow-shell-1.7.0.RELEASE.jar --spring.shell.commandFile=/home/atos/scdf/scdf-setup.cmd

echo "Done."
zsh
