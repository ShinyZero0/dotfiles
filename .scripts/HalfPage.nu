#!/usr/bin/env -S nu --no-std-lib

def _dirs [] {
	[ up down ]
}

def main [ direction: string@_dirs, amount: int ] {

	let click = (

		if $direction == "up" {
			4
		} else {
			5
		}
	)
	xdotool click --repeat $amount --delay 50 $click
}
