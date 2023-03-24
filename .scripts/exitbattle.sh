#!/bin/sh

win=$(xdotool getactivewindow)
xdotool windowactivate $win
xdotool keyup alt
xdotool key Escape;
for i in {1..6}; do
    xdotool key Down
    sleep 0.1
done
