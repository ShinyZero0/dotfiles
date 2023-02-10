EDITOR=nvim
win=$(xdotool getactivewindow)
alacritty --class floatwin -e bash -c "xsel -o | vipe | xsel -i -b"
xdotool windowactivate $win
xdotool key ctrl+v

