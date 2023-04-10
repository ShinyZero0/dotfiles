def "nu-cmp manpages" [] { (

    ^man -w 
    | split row ":" 
    | each { |d| ls ($d | to text | str trim ) } 
    | flatten 
    | each { |d| ls $d.name | get name 
        | path basename | str replace '\..*' "" } 
    | flatten
) }

export extern "man" [

    ...targets: string@"nu-cmp manpages"
]
