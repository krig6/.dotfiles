#!/bin/bash

FILE="/tmp/screenshot_$(date +%s).png"

# take screenshot (interactive selection)
import "$FILE"

# copy to clipboard
xclip -selection clipboard -t image/png -i "$FILE"

# default behavior: only clipboard + temp file
# optional save if -s flag is passed
if [ "$1" == "-s" ]; then
  SAVE_DIR="$HOME/Pictures/Screenshots"
  mkdir -p "$SAVE_DIR"

  cp "$FILE" "$SAVE_DIR/"
  echo "Saved to $SAVE_DIR/$(basename "$FILE")"
fi
