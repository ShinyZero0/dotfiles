#!/bin/sh
while [ true ]
do
    windowid=`xdotool getwindowfocus`
    windowclass=`xprop -id "$windowid" | grep CLASS`
    if [ "$windowclass" = 'WM_CLASS(STRING) = "Navigator", "firefox"' ]; then
        pkill picom
    fi
    sleep 0.5
done
