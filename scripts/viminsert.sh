EDITOR=nvim
win=$(xdotool getactivewindow)
kitty --class floatwin -- bash -c "xsel -o | vipe | xsel -b -i"
xdotool windowactivate $win
xdotool key ctrl+v

