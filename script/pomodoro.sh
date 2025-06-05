#!/bin/bash

min=${1:-1}
loops=${2:-2}
cooldown=${3:-1}

sec=$((min * 60))
cooldown_sec=$((cooldown * 60))
cooldown_message_sec=$((cooldown_sec * 1000))

startMessage="Pomodoro started! Focus for $min minute(s)..."
breakMessage="Take a break for $cooldown minute(s)."
doneMessage="Pomodoro ended!"

for ((i = 1; i <= loops; i++)); do
  notify-send --urgency=critical -t 5000 -a pomo "$startMessage"
  sleep $sec

  if [ $i -lt $loops ]; then
    notify-send --urgency=normal -t "$cooldown_message_sec" -a pomo "$breakMessage"
    sleep $cooldown_sec
  fi
done

notify-send --urgency=critical -t 0 -a pomo "$doneMessage"
