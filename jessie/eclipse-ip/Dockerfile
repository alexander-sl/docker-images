FROM alexsl/xenial-jdk:latest
MAINTAINER alexsl

RUN sudo apt-get update && \
    sudo dpkg --add-architecture i386 && \
    sudo apt-get update && \
    sudo apt-get install -y make gcc libc6:i386 gcc-multilib libncurses5-dev:i386 dpkg-dev && \
    sudo apt-get clean -y && \
    sudo rm -rf /var/lib/apt/lists/* && \
    sudo rm -rf /tmp/*
