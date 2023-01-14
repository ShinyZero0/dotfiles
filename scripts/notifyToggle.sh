#!/usr/bin/env bash
    isPaused=`dunstctl is-paused`
    if [ "$isPaused" = true ]; then
        dunstctl set-paused false
        echo ""
    else
        dunstctl set-paused true
        echo ""
    fi
