#!/bin/bash

# Spring CDF
export spring_security_user_name=u
export spring_security_user_password=p
export spring_autoconfigure_exclude=org.springframework.boot.autoconfigure.security.SecurityAutoConfiguration
export spring_cloud_dataflow_metrics_collector_uri=http://localhost:9494
export spring_cloud_dataflow_applicationProperties_stream_spring_cloud_stream_bindings_applicationMetrics_destination=metrics
export spring_cloud_dataflow_applicationProperties_stream_spring_metrics_export_includes=integration.channel.input**,integration.channel.output**
export spring_cloud_dataflow_metrics_collector_username=u 
export spring_cloud_dataflow_metrics_collector_password=p

#sudo service elasticsearch start 
#sudo service kibana start
/home/docker/kafka/kafka_2.11-2.0.0/bin/zookeeper-server-start.sh -daemon /home/docker/kafka/kafka_2.11-2.0.0/config/zookeeper.properties
/home/docker/kafka/kafka_2.11-2.0.0/bin/kafka-server-start.sh -daemon /home/docker/kafka/kafka_2.11-2.0.0/config/server.properties
nohup java -Xmx1024m -jar /home/docker/scdf/spring-cloud-dataflow-server-local-1.7.0.RELEASE.jar --logging.file=/home/docker/scdf/scdf.log >/dev/null 2>&1 &
nohup java -Xmx64m -jar /home/docker/scdf/metrics-collector-kafka-2.0.0.RELEASE.jar --logging.file=/home/docker/scdf/collector.log --server.port=9494 >/dev/null 2>&1 &
until $(curl --output /dev/null --silent --fail http://localhost:9393); do printf '.'; sleep 1; done
java -jar /home/docker/scdf/spring-cloud-dataflow-shell-1.7.0.RELEASE.jar --spring.shell.commandFile=/home/docker/scdf/scdf-import.cmd
bash
