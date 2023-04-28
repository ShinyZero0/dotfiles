#!/usr/bin/env nu

let pkgs = (open ~/.stuff/install/packages.json)

$pkgs 
| find "void-repo"
| each {|pkg| sudo xbps-install $pkg}

$pkgs 
| find -v "void-repo"
| each {|pkg| sudo xbps-install $pkg}
