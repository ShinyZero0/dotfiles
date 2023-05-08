#!/usr/bin/env nu

use nq-utils.nu *

sleep 5sec

pkg list-installed | lines 
| each { |l| 
    $l | str replace "/.*" ""
}
| range 1..
| save -f ~/.cache/pkg-installed.json

pkg list-all | lines 
| each { |l| 
    $l | str replace "/.*" ""
}
| range 1..
| save -f ~/.cache/pkg-all.json

~/.scripts/packages/termux-packages.nu

