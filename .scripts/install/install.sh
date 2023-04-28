#!/usr/bin/env bash

# activate sudo timer
sudo echo 0

#  ╭──────────────────────────────────────────────────────────╮
#  │                      Install stuff                       │
#  ╰──────────────────────────────────────────────────────────╯

sudo xbps-install -Suy xbps
sudo xbps-install -y nushell nix
~/.install/packages.nu
nq ~/.stuff/install/fonts.nu

pip install xkeysnail
usermod -a -G input zero

mkdir -p ~/.misc/
mkdir -p ~/sources/

# cp ~/.misc/Challenger-Deep.rasi /usr/share/rofi/themes/ # i lost that theme

#  ╭──────────────────────────────────────────────────────────╮
#  │                     Install .NET SDK                     │
#  ╰──────────────────────────────────────────────────────────╯

# cd ~/.misc/
# wget 'https://dot.net/v1/dotnet-install.sh'
# bash dotnet-install.sh -c STS
# cd
