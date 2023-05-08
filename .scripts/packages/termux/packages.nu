#!/usr/bin/env nu

def main [] {

	apt-mark showmanual
		| lines
		| to json
		| save -f ~/.scripts/install/termux/assets/packages.json
}
