#!/usr/bin/env nu

def "main" [] {
	bspc query -N -n .hidden.window
	| lines
	| wrap id
	| each { |it|
		upsert window (xdotool getwindowname $it.id)
	}
	| format '{id} : {window}'
	| to text
	| rofi -dmenu -i -auto-select
	| split row -r '\s+'
	| first
	| do { |it|
		bspc node $it -g hidden=off
		bspc node $it -d (bspc query -D -d focused)
	} $in
}
