#!/usr/bin/env nu

pkg list-installed o+e> /dev/null
| lines | each { |l| 
    $l | str replace "/.*" ""
}
| range (1)..(-1)
| save -f ~/.cache/pkg-installed.json

pkg list-all o+e> /dev/null| lines 
| each { |l| 
    $l | str replace "/.*" ""
}
| range (1)..(-1)
| save -f ~/.cache/pkg-all.json

