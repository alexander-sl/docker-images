FROM alexsl/jessie-base:latest
MAINTAINER alexsl

RUN export uid=1000 gid=1000

RUN sudo echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" \
    | sudo tee /etc/apt/sources.list.d/webupd8team-java.list && \
    sudo echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" \
    | sudo tee -a /etc/apt/sources.list.d/webupd8team-java.list && \
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 && \
    sudo apt-get update && \
    sudo echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true \ 
    | sudo /usr/bin/debconf-set-selections && \
    sudo apt-get install -y oracle-java8-installer libxext-dev libxrender-dev libxtst-dev && \
    sudo apt-get clean -y && \
    sudo rm -rf /var/lib/apt/lists/* && \
    sudo rm -rf /tmp/*

RUN sudo apt-get update && \
    sudo apt-get install -y libgtk2.0-0 libcanberra-gtk-module libxext-dev \
    libxrender-dev libxtst-dev && \
    sudo apt-get clean -y && \
    sudo rm -rf /var/lib/apt/lists/* && \
    sudo rm -rf /tmp/*

ENV DISPLAY=${DISPLAY}

RUN wget http://ftp-stud.fht-esslingen.de/pub/Mirrors/eclipse/technology/epp/downloads/release/neon/2/eclipse-cpp-neon-2-linux-gtk-x86_64.tar.gz && \
    tar xzvf eclipse-cpp-neon-2-linux-gtk-x86_64.tar.gz && \
    rm eclipse-cpp-neon-2-linux-gtk-x86_64.tar.gz

CMD [ "/home/developer/eclipse/eclipse"]

