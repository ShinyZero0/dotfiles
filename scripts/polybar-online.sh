#!/bin/sh
echo "%{F#ff8080}ﴹ"
connection=false
while [ true ]
do
    wget -t 1 -T 1 -q --spider 1.1.1.1

    if [ $? -eq 0 ]; then
        if [ "$connection" = false ]; then
            echo "度"
            connection=true
            notify-send -t 5000 "Подключено"
        fi
    else
        if [ "$connection" = true ]; then
            echo "%{F#ff8080}ﴹ"
            connection=false
            notify-send -t 5000 -u critical "Соединение потеряно"
        fi
    fi
    sleep 1
done
