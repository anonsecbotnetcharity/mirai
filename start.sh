#!/bin/bash

screen -S AXIS_session -d -m "./AXIS 35829 1 35821"
tmux new-session -d -s playit_session "playit"
tmux attach-session -t playit_session