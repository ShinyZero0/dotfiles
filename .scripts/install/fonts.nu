#!/usr/bin/env nu
#  ╭──────────────────────────────────────────────────────────╮
#  │                      Install fonts                       │
#  ╰──────────────────────────────────────────────────────────╯

let FontDir = ~/.local/share/fonts/
mkdir $FontDir
cd $FontDir
mut $fonts = [

    "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/InconsolataLGC.zip"
    "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/IBMPlexMono.zip"
]
mut i = 0

$fonts | each {|f|
    let file = $"font($i).zip"
    wget $f -O $file
    atool -x $file
    rm $file
    $i = $i + 1
}
fd -g "*Windows*" -x rm "{}"
fc-cache -rf
cd
