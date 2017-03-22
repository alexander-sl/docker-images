FROM alexsl/xenial-base:latest
MAINTAINER alexsl

RUN sudo apt-get update && sudo add-apt-repository ppa:webupd8team/java -y && \
    sudo apt-get update && \
    sudo echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections && \
    sudo apt-get install -y oracle-java8-installer libxext-dev libxrender-dev libxtst-dev && \
    sudo apt-get clean -y && \
    sudo rm -rf /var/lib/apt/lists/* && \
    sudo rm -rf /tmp/*


