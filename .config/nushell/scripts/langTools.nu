#!/usr/bin/env nu

def lang-tools [
    --lang(-l): string
] {
    let toolsFile = ~/.stuff/langTools.json
    open $toolsFile
    | where { ||
        get languages | any { || 
            str contains -i ( $lang | default "" )
        }
    } 
}
