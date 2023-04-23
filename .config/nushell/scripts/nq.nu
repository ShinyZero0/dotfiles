def lsq [
	--active(-a): bool
	--threads(-t): bool
] {

    let tasks = (fd -t f . $env.NQDIR | lines)
    if $active {

		$tasks | where { ||
			( _qstatus $in) == "active"
		}
    } else if false {
		$tasks
	} else {
		$tasks
	}
}

def _qstatus [
	path: string
] {

    let file = ( $path | open )

    if ( $file | str contains "[exited with status" ) {
        "exited"
    } else if ($file | str contains "[killed by signal") {
        "killed"
    } else {
        "active"
    }
}

def nq [
	--now(-n): bool
	...args: any
] {

	if ($now) {
		let nqdir = ($env.NQDIR | str join (random integer | into string) )
		NQDIR=$nqdir ^nq nu -c $"( $args | str join ' ' )"
		print $nqdir
	} else {
		^nq nu -c $"( $args | str join ' ' )"
	}
}
def "nq clean" [] {
	lsq | 
}
