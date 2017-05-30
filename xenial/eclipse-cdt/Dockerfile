FROM alexsl/xenial-gtk:latest
MAINTAINER alexsl

RUN export uid=1000 gid=1000

ENV DISPLAY=${DISPLAY}

RUN wget -O - http://ftp-stud.fht-esslingen.de/pub/Mirrors/eclipse/technology/epp/downloads/release/neon/3/eclipse-cpp-neon-3-linux-gtk-x86_64.tar.gz | tar xz

CMD [ "/home/developer/eclipse/eclipse"]


