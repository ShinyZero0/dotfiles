#!/bin/sh
echo "%{F#ff8080}ﴹ"
while [ true ]
do
    wget -T 1 -q --spider https://google.com

    if [ $? -eq 0 ]; then
        echo "度"
    else
        echo "%{F#ff8080}ﴹ"
    fi
    sleep 1
done
