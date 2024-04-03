#!/usr/bin/env bash

kill --all ".polybar-wrappe"

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar -c "/home/kios/.config/polybar/config.ini" --reload main &
  done
else
  polybar --reload main &
fi
