FROM alexsl/xenial-gtk:latest
MAINTAINER alexsl

ENV DISPLAY=${DISPLAY}

RUN export uid=1000 gid=1000 && \
    wget http://ftp-stud.fht-esslingen.de/pub/Mirrors/eclipse/technology/epp/downloads/release/neon/2/eclipse-cpp-neon-2-linux-gtk-x86_64.tar.gz && \
    tar xzvf eclipse-cpp-neon-2-linux-gtk-x86_64.tar.gz && \
    rm eclipse-cpp-neon-2-linux-gtk-x86_64.tar.gz

CMD [ "/home/developer/eclipse/eclipse"]
