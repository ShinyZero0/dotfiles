#!/usr/bin/env bash

xbps-install -y \
i3 polybar picom rofi nitrogen maim \
python3-pip nodejs-npm cargo \
git yadm zsh sd \
xsel xclip neovim \
wget curl unzip atool \
lf ripgrep skim fzf duf \

pip install xkeysnail
usermod -a -G input zero

# cargo install skim

cp ~/.util/Challenger-Deep.rasi /usr/share/rofi/themes/
mkdir -p ~/.local/share/fonts/
cd ~/.local/share/fonts/
wget 'https://fonts.google.com/download?family=Roboto' -O Roboto.zip
atool -x Roboto.zip
fc-cache -rf
