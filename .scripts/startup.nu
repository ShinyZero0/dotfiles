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
	"~/.config/sv/i3lock",
	"~/.config/sv/i3helper",
	"~/.config/sv/xkeysnail",
]
for sv in $services {
	try { ln -s ($sv | path expand) $svdir }
}
exec runsv ~/.config/sv/runsvdir-graphic 
