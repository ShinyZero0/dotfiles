#!/usr/bin/env nu

def langtools [
    --lang(-l): string
] {
    let toolsFile = ~/.scripts/langTools/langTools.json
    open $toolsFile
    | where { ||
        get languages | any { || 
            str contains -i $lang
        }
    } 
}
