#!/usr/bin/env nu

def _dirs [] {
	[ up down ]
}

def main [ direction: string@_dirs ] {
	mut click = 0
	if $direction == "up" {
		$click = 4
	} else {
		$click = 5
	}
	xdotool click --repeat 4 --delay 50 $click
}
