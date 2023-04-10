#!/usr/bin/env bash

#  ╭──────────────────────────────────────────────────────────╮
#  │                      Install stuff                       │
#  ╰──────────────────────────────────────────────────────────╯

xbps-install -Suy xbps
xbps-install -y \
wget curl unzip atool \
git yadm nushell sd \
i3 polybar picom rofi nitrogen maim \
python3-pip nodejs-npm cargo nix \
xsel xclip \
neovim lf ripgrep skim fzf duf \
nq \

pip install xkeysnail
usermod -a -G input zero

mkdir -p ~/.misc/

# cp ~/.misc/Challenger-Deep.rasi /usr/share/rofi/themes/ # i lost that theme

#  ╭──────────────────────────────────────────────────────────╮
#  │                      Install fonts                       │
#  ╰──────────────────────────────────────────────────────────╯

fonts=~/.local/share/fonts/
mkdir -p $fonts
cd $fonts
wget 'https://fonts.google.com/download?family=Roboto' -O Roboto.zip
atool -x Roboto.zip
fc-cache -rf

#  ╭──────────────────────────────────────────────────────────╮
#  │                     Install .NET SDK                     │
#  ╰──────────────────────────────────────────────────────────╯

cd ~/.misc/
wget 'https://dot.net/v1/dotnet-install.sh'
bash dotnet-install.sh -c STS

