#!/bin/sh

PRIMARY=$(xrandr | grep " connected" | grep "primary" | cut -d" " -f1)
CONNECTED=$(xrandr | grep " connected" | grep -v "primary" | grep -v "[0-9]\+x[0-9]\+" | cut -d" " -f1)

current_display=$PRIMARY
for i in $CONNECTED; do
  xrandr --output "$i" --above "$current_display" --auto;
  current_display="$i"
done
