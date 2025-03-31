#!/bin/bash

SESSION="coding"

# Check if the session exists
tmux has-session -t $SESSION 2>/dev/null
if [ $? != 0 ]; then
  # Create a new session named "odin" then go to the project directory
  tmux new-session -d -s $SESSION -n "odin"
  tmux send-keys -t $SESSION:1 "odin" C-m

  # Create a second window named "gitlogs"
  tmux new-window -t $SESSION -n "gitlogs"
  tmux send-keys -t $SESSION:2 "proj" C-m
  tmux send-keys -t $SESSION:2 "c" C-m
  tmux send-keys -t $SESSION:2 "gs" C-m

  # Create a third window named "dev"
  tmux new-window -t $SESSION -n "dev"
  tmux send-keys -t $SESSION:3 "proj" C-m
  tmux send-keys -t $SESSION:3 "c" C-m
  tmux send-keys -t $SESSION:3 "dev" C-m
  # Go back to the first window (odin)
  tmux select-window -t $SESSION:1
fi

# DON'T FORGET TO MAKE THE SCRIPT EXECUTABLE
# chmod +x ~/.tmux_startup.sh
