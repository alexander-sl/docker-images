FROM ubuntu:xenial
MAINTAINER alexsl

RUN apt-get update && apt-get install -y software-properties-common && \
    apt-get install -y libxext-dev libxrender-dev libxtst-dev sudo vim \
    ssh git mercurial subversion vim && \
    apt-get -y clean && \
    mkdir -p /home/alex && \
    echo "alex:x:1000:1000:alex,,,:/home/alex:/bin/bash" >> /etc/passwd && \
    echo "alex:x:1000:" >> /etc/group && \
    echo "alex ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/alex && \
    chmod 0440 /etc/sudoers.d/alex && \
    chown alex:alex -R /home/alex

USER alex
ENV HOME /home/alex
WORKDIR /home/alex
