#!/usr/bin/env bash
if [[ $(pgrep pavucontrol) ]]; then
	pkill pavucontrol
else
	pavucontrol &
fi
