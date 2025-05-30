#!/bin/bash

min=${1:-1}
loops=${2:-1}
cooldown=${3:-1}

sec=$((min * 60))
cooldown_sec=$((cooldown * 60))
cooldown_message_sec=$((cooldown_sec * 1000))

# minutes=${min:?⏰ Error: Duration in minutes is required.}
# message=${msg:?📝 Error: Notification message is required.}

# local errorMessage="Duration must be greater than 0 minutes."

startMessage="Pomodoro time started! Focus for $min minute(s)..."
breakMessage="Take a break for a minute."
doneMessage="Done! Type 'g' in the terminal to start it again."

# if [ $min -eq 0 ]; then
#   echo $errorMessage
#   return 1
# fi
echo "Loops: $loops"

for ((i = 1; i <= loops; i++)); do
  echo "Instance: $i"
  notify-send --urgency=critical -t 5000 -a pomo "$startMessage"
  sleep $sec
  # notify-send --urgency=critical -t 0 -a pomo $breakMessage

  if [ $i -lt $loops ]; then
    # echo "Cooldown for $cooldown minutes(s)..."
    echo "Break: $i"
    notify-send --urgency=critical -t "$cooldown_message_sec" -a pomo "$breakMessage"
    sleep $cooldown_sec
  fi
done

notify-send --urgency=critical -t 0 -a pomo "$doneMessage"
