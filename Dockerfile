FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y software-properties-common apt-transport-https wget sudo apt-utils openjdk-8-jre
RUN adduser --disabled-password --gecos '' docker
RUN adduser docker sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER docker

#Install ELK
RUN wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
RUN echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list
RUN sudo apt-get update
RUN sudo DEBIAN_FRONTEND=noninteractive apt-get install elasticsearch kibana
RUN sudo sed -i 's/#server.host: "localhost"/server.host: "0.0.0.0"/g' /etc/kibana/kibana.yml

#Install Kafka
RUN mkdir /home/docker/kafka
RUN wget http://ftp.man.poznan.pl/apache/kafka/2.0.0/kafka_2.11-2.0.0.tgz -P /home/docker/kafka
RUN cd /home/docker/kafka && tar zxvf kafka_2.11-2.0.0.tgz

#Install CDF
RUN mkdir /home/docker/scdf
RUN wget http://repo.spring.io/libs-release/org/springframework/cloud/metrics-collector-kafka/2.0.0.RELEASE/metrics-collector-kafka-2.0.0.RELEASE.jar -P /home/docker/scdf
RUN wget https://repo.spring.io/release/org/springframework/cloud/spring-cloud-dataflow-server-local/1.7.0.RELEASE/spring-cloud-dataflow-server-local-1.7.0.RELEASE.jar -P /home/docker/scdf
RUN wget https://repo.spring.io/release/org/springframework/cloud/spring-cloud-dataflow-shell/1.7.0.RELEASE/spring-cloud-dataflow-shell-1.7.0.RELEASE.jar -P /home/docker/scdf

RUN cd /home/docker/kafka && tar zxvf kafka_2.11-2.0.0.tgz

COPY startup.sh /home/docker/startup.sh

ENTRYPOINT /home/docker/startup.sh

EXPOSE 8080 80 5601

