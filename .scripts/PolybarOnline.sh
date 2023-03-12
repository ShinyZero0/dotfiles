#!/bin/sh
echo "%{F#ff8080}ﴹ"
connection=false
while [ true ]
do
    wget -t 2 -T 1 -q --spider 1.1.1.1

    if [ $? -eq 0 ]; then
        if [ "$connection" = false ]; then
            connection=true
            echo "度"
            notify-send -t 5000 "Подключено"
        fi
        sleep 1
    else
        if [ "$connection" = true ]; then
            connection=false
            echo "%{F#ff8080}ﴹ"
            notify-send -t 5000 -u critical "Соединение потеряно"
        fi
    fi
done
