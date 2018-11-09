FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y software-properties-common apt-transport-https wget sudo apt-utils openjdk-8-jre curl git zsh
RUN adduser --disabled-password --gecos '' atos
RUN adduser atos sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER atos

RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

#Install ELK
RUN wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
RUN echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list
RUN sudo apt-get update
RUN sudo DEBIAN_FRONTEND=noninteractive apt-get install elasticsearch kibana
RUN sudo sed -i 's/#server.host: "localhost"/server.host: "0.0.0.0"/g' /etc/kibana/kibana.yml
RUN sudo bash -c 'echo ES_JAVA_OPTS=\"-Xmx1g -Xms512m\" >> /etc/default/elasticsearch'

#Install Kafka
RUN mkdir /home/atos/kafka
RUN wget http://ftp.man.poznan.pl/apache/kafka/2.0.0/kafka_2.11-2.0.0.tgz -P /home/atos/kafka
RUN cd /home/atos/kafka && tar zxvf kafka_2.11-2.0.0.tgz

#Install CDF
RUN mkdir /home/atos/scdf
RUN wget http://repo.spring.io/libs-release/org/springframework/cloud/metrics-collector-kafka/2.0.0.RELEASE/metrics-collector-kafka-2.0.0.RELEASE.jar -P /home/atos/scdf
RUN wget https://repo.spring.io/release/org/springframework/cloud/spring-cloud-dataflow-server-local/1.7.0.RELEASE/spring-cloud-dataflow-server-local-1.7.0.RELEASE.jar -P /home/atos/scdf
RUN wget https://repo.spring.io/release/org/springframework/cloud/spring-cloud-dataflow-shell/1.7.0.RELEASE/spring-cloud-dataflow-shell-1.7.0.RELEASE.jar -P /home/atos/scdf
COPY scdf-setup.cmd /home/atos/scdf/scdf-setup.cmd
COPY jsonArrayToObject.groovy /home/atos/scdf/jsonArrayToObject.groovy

COPY startup.sh /home/atos/startup.sh

ENTRYPOINT /home/atos/startup.sh

EXPOSE 5601 9494 9393

