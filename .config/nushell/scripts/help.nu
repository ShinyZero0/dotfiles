def _try_full_help [command: string] {
    try {
        let exit = (^$command --help | complete | get exit_code)
        if $exit != 0 {
            false
        }
        true
    } catch {
        false
    }
}

def _try_help [command: string] {
    try {
        let exit = (^$command -h | complete | get exit_code)
        if $exit != 0 {
            false
        }
        true
    } catch {
        false
    }
}

def _try_builtin [command: string] {
    try {
        help $command
        return true
    } catch {
        return false
    }
}

def _help [
	--find(-f): bool
	command: string
] {
	mut f = ""
	if $find { $f = "--find" }
    let builtin = if not ($command | str starts-with "^") {
        _try_builtin $command
    }
    if not $builtin {
        if (_try_full_help $command) {
            ^$command --help
        } else if (_try_help $command) {
            ^$command -h
        } else {
            # tldr $command
        }
    } else {
        help ([ $f $command ] | str join ' ')
    }
}
alias help = _help
