# vim: ft=conf
source $BYOBU_PREFIX/share/byobu/profiles/tmux

set -g message-style bg=$BYOBU_DARK,fg=$BYOBU_LIGHT
set -g message-command-style bg=$BYOBU_DARK,fg=$BYOBU_LIGHT
set-option -g mode-style bg=$BYOBU_DARK,fg=$BYOBU_LIGHT
set-option -ga terminal-overrides ",alacritty:Tc"
set -g default-terminal "alacritty"
set -g mouse on
