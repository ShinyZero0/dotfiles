#!/usr/bin/env nu

let svdir = ( "~/.local/share/service-graphic/" | path expand )
rm -rf $svdir
mkdir $svdir
let services = [

	"~/.config/sv/keynav",
	"~/.config/sv/corectrl",
	"~/.config/sv/pipewire",
	"~/.config/sv/pipewire-pulse",
	"~/.config/sv/wireplumber",
	"~/.config/sv/picom",
	"~/.config/sv/polybar",
	"~/.config/sv/wallpapers",
	"~/.config/sv/sxhkd",
	"~/.config/sv/keyd-app",
]
for sv in $services {
	try { ln -s ($sv | path expand) $svdir }
}
playerctld daemon
exec runsv ~/.config/sv/runsvdir-graphic 
