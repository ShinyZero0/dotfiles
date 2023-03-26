#!/usr/bin/env bash

# * packages:
sudo dnf install -y \
i3 polybar picom rofi \
python3-pip nodejs-npm cargo \
git yadm zsh sd \
xsel xclip neovim

# * [xkeysnail](https://github.com/mooz/xkeysnail):
sudo pip install xkeysnail
sudo usermod -a -G input $USER

# * [skim](https://github.com/lotabout/skim/) fzf alternative:
cargo install skim

# Set [Challenger Deep](https://github.com/challenger-deep-theme/xresources) as xresources  
wget -O ~/.Xresources https://raw.githubusercontent.com/challenger-deep-theme/xresources/master/challenger-deep.xdefaults
