FROM ubuntu:latest

LABEL Maintainer="Hyunho Kim"
LABEL Description="Presto Worker"
LABEL Version="0.0.1"

ARG WORKER_PORT
ARG NODE_ID
ARG COORDINATOR_HOST
RUN apt-get update && apt-get -y upgrade

# java
RUN apt-get install openjdk-11-jdk -y
RUN apt-get install wget -y

# miniconda 
RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && bash Miniconda3-latest-Linux-x86_64.sh -p /miniconda -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh 
ENV PATH=/miniconda/bin:${PATH}
RUN conda --version
RUN conda init

RUN useradd -ms /bin/bash presto
USER presto
WORKDIR /home/presto
EXPOSE 8080

RUN mkdir presto-worker
RUN mkdir -p presto-worker/data

COPY  ./presto-worker /home/presto/presto-worker
RUN ls /home/presto/presto-worker/

WORKDIR /home/presto/presto-worker/etc

# config.properties
RUN echo "coordinator=false" >> config.properties
RUN echo "http-server.http.port=${WORKER_PORT}" >> config.properties
RUN echo "query.max-memory=5GB" >> config.properties
RUN echo "query.max-memory-per-node=1GB" >> config.properties
RUN echo "query.max-total-memory-per-node=2GB" >> config.properties
RUN echo "discovery.uri=http://${COORDINATOR_HOST}:8080" >> config.properties

RUN echo "node.environment=prestocluster" >> node.properties
RUN echo "node.id=${NODE_ID}" >> node.properties
RUN echo "node.data-dir=/home/presto/data" >> node.properties
ENTRYPOINT /home/presto/presto-worker/bin/launcher run