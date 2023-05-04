use utils.nu [
	_relpath
	invert
]

export def lsq [
	--all(-a): bool
] {

    if $all {
		( fd -t f . $env.NQDIR | lines )
	} else {
		( fd -t x . $env.NQDIR | lines )
	}
}

export def fq [
	
	--thread(-t): any@_nqThreads
	proc?: string@_nqProcesses
] {
	if ( $proc | is-empty ) {
		let shownThread = ( 
			(
				$thread 
				| default (
					_nqThreads 
					| get 0
				)
				| into string
			)
			| _expandNQ
		)	
		with-env [ NQDIR $shownThread ] { || ^fq }
	} else {
		let shown = (
			$proc 
			| parse '{thread}/{process}' 
		)
		with-env [ NQDIR ( $shown.thread.0 | _expandNQ ) ] { || ^fq ($shown.process.0) }
	}
}

export def nq [
	--now(-n): bool
	...args: any
] {

	if ($now) {
		let nqdir = ($env.NQDIR | path join ( "q" + (random chars | into string) ) )
		NQDIR=$nqdir ^nq nu -c $"( $args | str join ' ' )"
		print $nqdir
	} else {
		^nq nu -c $"( $args | str join ' ' )"
	}
}

export def "nq clean" [] {

	let active = ( lsq -a )
	lsq 
	| filter { || 
		not $in in $active
	} 
	| each { || rm $in }
}
export def "nq kill" [

	...args: string@_nqProcesses
] {

}

def _nqProcesses [] {
	let procs = (lsq)
	$procs
	| each { || _relpath $env.NQDIR }
	| wrap value 
	| merge (
		$procs
		| each { || 
			open $in 
				| lines 
				| get 0
				| parse "exec nq nu -c '{foo}'" 
				| get foo 
				| get 0
		} 
		| wrap description
	)
}

def _nqThreads [] {
	ls $env.NQDIR 
	| get name 
	| each {|| _relpath $env.NQDIR }
	| where { || 
		let thread = $in
		fd -d 1 -t x . ( $env.NQDIR | path join $thread  ) 
		| lines
		| is-empty
		| invert
	}
}

def _expandNQ [] {
	
	let short = $in
	$env.NQDIR | path join $short 
}
