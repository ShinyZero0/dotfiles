#!/usr/bin/env nu

let svdir = ( "~/.local/share/service-graphic/" | path expand )
let services = [

	"~/.config/sv/keynav",
	"~/.config/sv/corectrl",
	"~/.config/sv/pipewire",
	"~/.config/sv/picom",
	"~/.config/sv/polybar",
	"~/.config/sv/dex-autostart",
	"~/.config/sv/wallpapers",
	"~/.config/sv/i3lock",
	"~/.config/sv/i3helper",
	"~/.config/sv/xkeysnail",
	"~/.config/sv/xkeysnail-fix-after",
]
rm -rf $svdir
mkdir $svdir
for sv in $services {
	try { ln -s ($sv | path expand) $svdir }
}
runsv ~/.config/sv/runsvdir-graphic 
