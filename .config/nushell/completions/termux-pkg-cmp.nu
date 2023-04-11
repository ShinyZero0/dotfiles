def "nu-cmp termux pkg installed" [] {

    open ~/.cache/pkg-installed.json
}
def "nu-cmp termux pkg all" [] {

    open ~/.cache/pkg-all.json
}
export extern "pkg upgrade" [

    -y
]
export extern "pkg install" [

    ...targets: string@"nu-cmp termux pkg all" 
    -y
]
export extern "pkg remove" [

    ...targets: string@"nu-cmp termux pkg installed"
]
