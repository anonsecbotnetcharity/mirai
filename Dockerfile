FROM ubuntu:latest

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y tzdata screen gcc gnupg gnupg1 gnupg2 curl tmux && \
    ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata

RUN curl -SsL https://playit-cloud.github.io/ppa/key.gpg | apt-key add -
RUN curl -SsL -o /etc/apt/sources.list.d/playit-cloud.list https://playit-cloud.github.io/ppa/playit-cloud.list

RUN apt-get update && \
    apt-get install -y playit

COPY AXIS_CNC.c /app/AXIS_CNC.c
COPY start.sh /app/start.sh
WORKDIR /app

RUN gcc -o AXIS AXIS_CNC.c -pthread && \
    chmod +x start.sh

CMD ["/app/start.sh"]
