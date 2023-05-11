#!/usr/bin/env nu

def main [] {
	let pkgs = (open ( _this ./assets/packages.json ))
	
	$pkgs 
		| where {|| "void-repo" in $in}
		| sudo xbps-install $in
	
	$pkgs
		| where not {|| "void-repo" not-in $in}
		| sudo xbps-install $in
	nq home-manager switch
}
