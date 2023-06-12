#!/usr/bin/env bash

sleep 2
setxkbmap us,ru -option 'grp:alt_shift_toggle'
xset r rate 250 15
# sv restart ~/.local/share/service-graphic/polybar
