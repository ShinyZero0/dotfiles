def "nu-cmp xbps local packages" [] {

    ^xbps-query -l | lines | each {|line| $line |  parse -r 'ii\s+(?P<value>\S+)-\S+\s+(?P<description>.+) ' | into record} 
}
def "nu-cmp xbps all packages" [] {

    open ~/xbpsDB.json # see ~/.scripts/xbps-cache.nu
}
export extern "xbps-remove" [ 

    ...targets: string@"nu-cmp xbps local packages" 
]
export extern "xbps-install" [

    ...targets: string@"nu-cmp xbps all packages"
]
