FROM alexsl/xenial-gtk:latest
MAINTAINER alexsl

RUN export uid=1000 gid=1000

ENV DISPLAY=${DISPLAY}

RUN wget https://download.jetbrains.com/python/pycharm-community-2016.3.3.tar.gz && \
    tar xzvf pycharm-community-2016.3.3.tar.gz && \
    rm pycharm-community-2016.3.3.tar.gz

CMD [ "/home/developer/pycharm-community-2016.3.3/bin/pycharm.sh"]


