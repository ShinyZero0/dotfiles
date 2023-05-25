#!/usr/bin/env bash

if [[ $(pgrep picom) ]]; then
	sv down ~/.local/share/service-graphic/picom/
else
	sv up ~/.local/share/service-graphic/picom/
fi

