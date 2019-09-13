#!/usr/bin/env bash

# terminate already running instances
killall -q polybar

# wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# launch bar only on main monitor
#MONITOR=$(polybar --list-monitors | grep primary | cut -d":" -f1)
#polybar --reload mybar &

### launch bars 
for m in $(polybar --list-monitors | cut -d":" -f1); do
  echo $m
  Monitor=$m polybar --reload mybar &
done

echo "bars launched"

