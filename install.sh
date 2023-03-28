#!/usr/bin/env bash

dnf install -y \
i3 polybar picom rofi \
python3-pip nodejs-npm cargo \
git yadm zsh sd \
xsel xclip neovim

pip install xkeysnail
usermod -a -G input $USER

cargo install skim

wget -O ~/.Xresources https://raw.githubusercontent.com/challenger-deep-theme/xresources/master/challenger-deep.xdefaults
