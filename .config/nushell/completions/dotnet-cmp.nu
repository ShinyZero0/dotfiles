#!/usr/bin/env nu

def "nu-cmp dotnet" [context: string] {

    ^dotnet complete ($context | split words | skip 1 | str join " ") | lines
}

export extern "dotnet" [ 

    ...args: any@"nu-cmp dotnet"
]
