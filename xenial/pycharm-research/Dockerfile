FROM alexsl/xenial-pycharm-2016.3.3:latest
MAINTAINER alexsl

RUN export uid=1000 gid=1000

ENV DISPLAY=${DISPLAY}

RUN sudo apt-get update && \
    sudo apt-get install python3-pip python3-tk -y && \
    pip3 install setuptools matplotlib && \
    sudo apt-get clean -y && \
    sudo rm -rf /var/lib/apt/lists/* && \
    sudo rm -rf /tmp/*

# CMD should be taken from parent image
#CMD [ "/home/developer/pycharm-community-2016.3.3/bin/pycharm.sh"]


