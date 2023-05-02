#!/bin/bash

# activate sudo timer
if [[ which xbps-install | is-empty ]]; then return; fi
sudo echo 0
sudo xbps-install -Syu xbps
sudo xbps-install -y nushell nix
~/.scripts/install/pc/init.nu
# nq ~/.install/fonts.nu

usermod -a -G input zero

