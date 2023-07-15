#!/usr/bin/env nu

let win = (xdotool getactivewindow)
xkb-switch -s us

xdotool windowactivate $win

xsel -ob | save -f ~/.viminsertoldclip.txt

xdotool keyup shift
xdotool keyup super
xdotool keyup alt
xdotool keyup ctrl
xdotool key ctrl+c

sleep 100ms

xsel -ob | save -f ~/.viminsert.md
open ~/.viminsertoldclip.txt | xsel -ib

alacritty --class floatwin -e nu -c "nvim -c 'set et' ~/.viminsert.md " 
open ~/.viminsert.md | xsel -ib
xdotool windowactivate $win
xdotool key ctrl+v 
sleep 3sec
open ~/.viminsertoldclip.txt | xsel -ib
