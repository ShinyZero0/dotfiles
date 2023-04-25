def "xbps local packages" [] {

    ^xbps-query -l | lines 
    | each { || 
        parse -r 'ii\s+(?P<value>\S+)-\S+\s+(?P<description>.+) ' | into record
    } 
}
def "xbps all packages" [] {

    open ~/.cache/xbps-cache.json  # see ~/.scripts/xbps-cache.nu
}
export extern "sudo xbps-remove" [ 

    ...targets: string@"xbps local packages" 
]
export extern "sudo xbps-install" [

    ...targets: string@"xbps all packages"
]
