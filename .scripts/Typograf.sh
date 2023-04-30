#!/bin/bash

win=$(xdotool getactivewindow)
xdotool windowactivate $win

xdotool keyup shift
xdotool keyup super
xdotool keyup alt
xdotool keyup ctrl

xdotool key ctrl+x

xclip -selection clipboard -o > .typograf.txt
npx typograf-cli -l ru,en-US .typograf.txt | xclip -selection clipboard -i

xdotool windowactivate $win 
xdotool keyup shift 
xdotool keyup super 
xdotool keyup alt 
xdotool keyup ctrl 
xdotool key ctrl+v
