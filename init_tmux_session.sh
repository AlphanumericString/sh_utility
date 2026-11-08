#!/bin/sh

SESSION_NAME=$(basename $(pwd))

tmux new -d -s "$SESSION_NAME" -n "editor"
tmux send-keys -t "$SESSION_NAME" "nvim" Enter
tmux new-window -t "$SESSION_NAME" -n "shell"
tmux attach -t "$SESSION_NAME"
