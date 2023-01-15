#!/usr/bin/env bash
    isPaused=`dunstctl is-paused`
    if [ "$isPaused" = false ]; then
        echo ""
    else
        echo "%{F#c991e1}"
    fi
