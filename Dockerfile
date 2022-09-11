FROM ubuntu:latest

LABEL Maintainer="Hyunho Kim"
LABEL Description="Presto Coordinator"
LABEL Version="0.0.2"

ARG PRESTO_VERSION=0.276.1
ARG PRESTO_SERVER_REPO="https://repo1.maven.org/maven2/com/facebook/presto/presto-server"

RUN apt-get update && apt-get -y upgrade

# java
RUN apt-get install openjdk-11-jdk -y \
    && apt-get install wget -y \
    && apt-get install vim -y  \
    && apt-get install uuid-runtime -y

# miniconda 
RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && bash Miniconda3-latest-Linux-x86_64.sh -p /miniconda -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh
ENV PATH=/miniconda/bin:${PATH}
RUN conda --version
RUN conda init

EXPOSE 8080
RUN useradd -ms /bin/bash presto
USER presto
WORKDIR /home/presto

ENV PRESTO_SERVER_HOME=/home/presto/presto-server
ENV PRESTO_LOG_DIRECTORY=/home/presto/data

RUN wget "${PRESTO_SERVER_REPO}/${PRESTO_VERSION}/presto-server-${PRESTO_VERSION}.tar.gz" \
    && tar -xvzf "presto-server-${PRESTO_VERSION}.tar.gz" \
    && mv "presto-server-${PRESTO_VERSION}" "presto-server" \
    && mkdir -p ${PRESTO_SERVER_HOME}/etc \
    && mkdir -p ${PRESTO_SERVER_HOME}/etc/catalog \
    && mkdir -p ${PRESTO_LOG_DIRECTORY} \
    && rm "presto-server-${PRESTO_VERSION}.tar.gz"

COPY ./scripts /home/presto/scripts
COPY ./catalog ${PRESTO_SERVER_HOME}/etc/catalog


ENTRYPOINT ["/home/presto/scripts/entrypoint.sh"]
CMD ["/home/presto/scripts/start-presto.sh"]