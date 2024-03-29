#!/usr/bin/env bash

isPaused=$(dunstctl is-paused)
if [ "$isPaused" = false ]; then
    echo "󰂚"
else
    echo "%{F#c991e1}󱏧"
fi

function ToggleDunst()
{
    isPaused=$(dunstctl is-paused)
    if [ "$isPaused" = true ]; then
        dunstctl set-paused false
        echo "󰂚"
    else
        dunstctl set-paused true
        echo "%{F#c991e1}󱏧"
    fi
}

trap ToggleDunst SIGUSR1

while true
do
    sleep 0.1
done

