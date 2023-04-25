#!/usr/bin/env nu

def "dotnet-cmp" [context: string] {

    ^dotnet complete ($context | split words | skip 1 | str join " ") | lines
}

export extern "dotnet" [ 

    ...args: string@"dotnet-cmp"
]
