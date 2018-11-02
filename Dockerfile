FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y software-properties-common apt-transport-https wget sudo apt-utils

RUN adduser --disabled-password --gecos '' docker
RUN adduser docker sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER docker

#Install ELK
RUN wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
RUN echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list
RUN sudo apt-get update
RUN sudo DEBIAN_FRONTEND=noninteractive apt-get install elasticsearch  kibana
RUN sudo /bin/systemctl daemon-reload
RUN sudo /bin/systemctl enable elasticsearch.service
RUN sudo /bin/systemctl enable kibana.service

EXPOSE 8080 80 5601
