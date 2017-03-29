FROM debian:jessie
MAINTAINER alexsl

RUN apt-get update && apt-get install -y software-properties-common && \
    apt-get install -y libxext-dev libxrender-dev libxtst-dev sudo \
    ssh git mercurial subversion vim && \
    apt-get -y clean && \
    mkdir -p /home/developer && \
    echo "developer:x:1000:1000:developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:1000:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown developer:developer -R /home/developer && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

USER developer
ENV HOME /home/developer
WORKDIR /home/developer
