def "nu-complete xbps local packages" [] {
xbps-query -l | lines | each {|line| $line |  parse -r 'ii\s+(?P<foo>\S+)-\S+\s+\S+' | get foo | to text }
}
export extern "xbps-remove" [ 
    ...targets: string@"nu-complete xbps local packages" 
]
