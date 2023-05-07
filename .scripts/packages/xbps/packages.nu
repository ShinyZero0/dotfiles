#!/usr/bin/env nu

xpkg -m
| lines 
| save -f ~/.scripts/install/pc/packages.json
