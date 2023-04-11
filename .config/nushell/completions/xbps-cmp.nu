def "nu-cmp xbps local packages" [] {

    ^xbps-query -l | lines 
    | each { || 
        parse -r 'ii\s+(?P<value>\S+)-\S+\s+(?P<description>.+) ' | into record
    } 
}
def "nu-cmp xbps all packages" [] {

    open ~/.cache/xbps-cache.json  # see ~/.scripts/xbps-cache.nu
}
export extern "sudo xbps-remove" [ 

    ...targets: string@"nu-cmp xbps local packages" 
]
export extern "sudo xbps-install" [

    ...targets: string@"nu-cmp xbps all packages"
]
