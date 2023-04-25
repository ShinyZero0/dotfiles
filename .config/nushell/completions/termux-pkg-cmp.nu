def "termux pkg installed" [] {

    open ~/.cache/pkg-installed.json
}
def "termux pkg all" [] {

    open ~/.cache/pkg-all.json
}
export extern "pkg upgrade" [

    -y
]
export extern "pkg install" [

    ...targets: string@"termux pkg all" 
    -y
]
export extern "pkg remove" [

    ...targets: string@"termux pkg installed"
]
export extern "pkg search" [

]
