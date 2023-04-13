#!/usr/bin/env nu

xbps-query -m
    | parse -r '(.+)-[0-9._]'
    | each {
        |pkg| $pkg.capture0
        | to text 
    } 
    | save -f ~/.install/packages.json
