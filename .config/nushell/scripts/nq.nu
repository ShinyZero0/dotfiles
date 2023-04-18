def lsq [] {

    ls $env.NQDIR
    | where { ||
        ( _qstatus $in.name ) == "active"
    }
}

def _qstatus [path: string] {

    let file = ( $path | open )

    if ( $file | str contains "[exited with status" ) {
        "exited"
    } else if ( $file | str contains "[killed by signal" ) {
        "killed"
    } else {
        "active"
    }
}

def nq [ ...args ] {

    ^nq nu -c $"( $args | str join ' ' )"
}
