FROM alexsl/jessie-eclipse:latest
MAINTAINER alexsl

RUN sudo apt-get update && \
    sudo dpkg --add-architecture i386 && \
    sudo apt-get update && \
    sudo apt-get install -y make gcc libc6:i386 gcc-multilib libncurses5-dev:i386 dpkg-dev \
    libreadline6-dev && \
    sudo ln -s /usr/bin/make /usr/bin/gmake && \
    sudo apt-get clean -y && \
    sudo rm -rf /var/lib/apt/lists/* && \
    sudo rm -rf /tmp/*

RUN sudo mkdir /home/marvell && \
    sudo chown -R developer:developer /home/marvell
