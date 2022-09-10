FROM ubuntu:latest

RUN apt-get update && apt-get -y upgrade


# java
RUN apt-get install openjdk-11-jdk -y
RUN apt-get install wget -y

# Miniconda 
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

RUN mkdir presto-coordi
RUN mkdir data

COPY  ./presto-coordi /home/presto/presto-coordi
RUN ls /home/presto/presto-coordi/
ENTRYPOINT /home/presto/presto-coordi/bin/launcher run