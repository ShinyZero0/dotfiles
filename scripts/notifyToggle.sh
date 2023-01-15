#!/usr/bin/env bash
    isPaused=`dunstctl is-paused`
    if [ "$isPaused" = true ]; then
        dunstctl set-paused false
    else
        dunstctl set-paused true
    fi
