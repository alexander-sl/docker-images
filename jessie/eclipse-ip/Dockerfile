FROM alexsl/jessie-eclipse:latest
MAINTAINER alexsl

RUN mkdir -p /home/developer/.local

COPY requirements.txt /home/developer/.local/requirements.txt

RUN sudo apt-get update && \
    sudo dpkg --add-architecture i386 && \
    sudo apt-get update && \
    sudo apt-get install -y make gcc libc6:i386 gcc-multilib libncurses5-dev:i386 dpkg-dev \
    libreadline6-dev gdb libffi-dev libssl-dev libssl-dev:i386 python3-pip && \
    sudo pip3 install --upgrade pip && \
    cd /home/developer/.local && \
    pip3 install --user -r requirements.txt && \
    sudo ln -s /usr/bin/make /usr/bin/gmake && \
    sudo apt-get clean -y && \
    sudo rm -rf /var/lib/apt/lists/* && \
    sudo rm -rf /tmp/*

RUN sudo mkdir /home/marvell && \
    sudo chown -R developer:developer /home/marvell
