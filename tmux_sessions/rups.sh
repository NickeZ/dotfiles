#!/bin/bash

cd ~/git/procServ-ng

tmux new-session -s 'rups' -d vim
tmux split-window -h
tmux split-window -v
tmux split-window -v

