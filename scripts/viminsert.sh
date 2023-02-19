EDITOR="nvim"

win=$(xdotool getactivewindow)
xkb-switch -s us

xdotool windowactivate $win

xdotool keyup shift
xdotool keyup super
xdotool keyup alt
xdotool keyup ctrl

xdotool key ctrl+c

kitty --class floatwin -- bash -c "xclip -selection clipboard -o | vipe --suffix txt > clip.txt && cat clip.txt | xclip -selection clipboard -i && xdotool windowactivate $win && xdotool keyup shift && xdotool keyup super && xdotool keyup alt && xdotool keyup ctrl && xdotool key ctrl+v"
