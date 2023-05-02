#!/usr/bin/env nu

def main [] {
	let pkgs = (open ( _pc packages.json ))
	
	$pkgs 
		| find "void-repo"
		| each { |pkg| sudo xbps-install $pkg }
	
	$pkgs 
		| find -v "void-repo"
		| each { |pkg| sudo xbps-install $pkg }
	nq home-manager switch
}
