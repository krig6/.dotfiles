#!/bin/bash

focus_minutes=${1:-25}
break_minutes=${2:-5}
cycles=${3:-8}

focus_seconds=$((focus_minutes * 60))
break_seconds=$((break_minutes * 60))
break_notify_timeout=$((break_seconds * 1000))

start_message="Time to pretend you're productive for $focus_minutes minutes! 💼🍅"
break_message="Break time! Go stare at the wall or do something equally important for $break_minutes minutes. 🧘‍♂️☕"
ended_message="You did it! Now go brag about your Pomodoro skills. 🎉🍕"

for ((i = 1; i <= cycles; i++)); do
  notify-send --urgency=critical -t 5000 -a pomo "$start_message"
  sleep "$focus_seconds"

  if [ "$i" -lt "$cycles" ]; then
    notify-send --urgency=normal -t "$break_notify_timeout" -a pomo "$break_message"
    sleep "$break_seconds"
  fi
done

notify-send --urgency=critical -t 0 -a pomo "$ended_message"
