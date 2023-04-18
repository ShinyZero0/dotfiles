def "builtins" [] {

    $nu.scope.commands | where is_builtin == true | get name
}

export extern help [ ...args: string@builtins ]
