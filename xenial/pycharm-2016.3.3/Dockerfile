FROM alexsl/xenial-gtk:latest
MAINTAINER alexsl

RUN export uid=1000 gid=1000

ENV DISPLAY=${DISPLAY}
ENV PYCHARM_VER 2016.3.3

RUN wget -O - https://download.jetbrains.com/python/pycharm-community-$PYCHARM_VER.tar.gz | tar xz

CMD [ "/home/developer/pycharm-community-$PYCHARM_VER/bin/pycharm.sh"]


