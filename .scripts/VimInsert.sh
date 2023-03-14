#!/bin/sh

EDITOR="nvim"

win=$(xdotool getactivewindow)
xkb-switch -s us

xdotool windowactivate $win

xclip -selection clipboard -o > viminsertoldclip.txt

xdotool keyup shift
xdotool keyup super
xdotool keyup alt
xdotool keyup ctrl

xdotool key ctrl+c
sleep 0.1

xclip -selection clipboard -o > viminsert.txt
cat viminsertoldclip.txt | xclip -selection clipboard -i 

kitty --class floatwin -- bash -c "$EDITOR viminsert.txt ; typograf-cli -l ru,en-US viminsert.txt | xclip -selection clipboard -i && xdotool windowactivate $win && xdotool keyup shift && xdotool keyup super && xdotool keyup alt && xdotool keyup ctrl && xdotool key ctrl+v && sleep 0.1"

cat viminsertoldclip.txt | xclip -selection clipboard -i 
