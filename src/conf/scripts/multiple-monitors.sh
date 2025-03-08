#!/bin/sh

xrandr --auto

PRIMARY=$(xrandr --query | grep " connected" | grep "primary" | cut -d" " -f1)
CONNECTED=$(xrandr --query | grep " connected" | grep -v "primary" | cut -d" " -f1)
SECOND=$(echo "$CONNECTED" | awk '{print $1}')

xrandr --output "$SECOND" --above "$PRIMARY" --auto
