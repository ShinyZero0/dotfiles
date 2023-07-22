#!/bin/sh

PID_FILE="/tmp/screencast.pid"
SCREENCAST_FILE="/tmp/screencast.mp4"

if [ -e $PID_FILE ]; then
    kill -s INT "$(cat $PID_FILE)"
    dragon-drop -x $SCREENCAST_FILE
    rm $PID_FILE
else
    ffmpeg -y -thread_queue_size 65536 \
    -hwaccel_output_format vaapi -hwaccel vaapi -vaapi_device /dev/dri/renderD128 \
    -f x11grab -i :0 \
    -vcodec libx264 \
    $SCREENCAST_FILE &
    echo $! > $PID_FILE
fi
