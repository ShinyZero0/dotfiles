#!/usr/bin/env fish
if pgrep picom 
	pkill picom
else
	picom -b
end

