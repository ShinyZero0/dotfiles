#!/usr/bin/env bash

if [[ $(pgrep picom) ]]; then
	pkill picom
else
	picom -b
fi

