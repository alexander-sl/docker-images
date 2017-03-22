FROM alexsl/xenial-gtk:latest
MAINTAINER alexsl

RUN export uid=1000 gid=1000

ENV DISPLAY=${DISPLAY}

COPY .java /home/alex/.java
COPY .PyCharmCE2016.3 /home/alex/.PyCharmCE2016.3

RUN wget https://download.jetbrains.com/python/pycharm-community-2016.3.3.tar.gz && \
    tar xzvf pycharm-community-2016.3.3.tar.gz && \
    rm pycharm-community-2016.3.3.tar.gz

RUN sudo chown -R alex:alex /home/alex/.java
RUN sudo chown -R alex:alex /home/alex/.PyCharmCE2016.3

CMD [ "/home/alex/pycharm-community-2016.3.3/bin/pycharm.sh"]


