#!/usr/bin/env nu

xpkg -m
    | lines | save -f ~/.install/packages.json
