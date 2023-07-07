#!/usr/bin/env nu

let path = (mktemp --suffix png)
qrencode -t PNG -o $path $env.QUTE_URL
imv $path
rm $path
