use utils.nu [
	"_relpath"
]

use pipes.nu [
	"invert"
]

export def "nq ls" [] {
	
	fd -t x . $env.NQDIR
		| lines
		| wrap name
		| merge ($in.name | _nqProcessesCommands)
		| merge ($in.name | _nqProcessesModtime)
		| recent
}
# input: process lockfiles list
# output: their modified time list
def _nqProcessesModtime [] {

	each { ls $in }
		| flatten
		| select modified
}

export def fq [

	--thread(-t): any@_nqThreads
	proc?: string@_nqActiveProcessesCompletion
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
		with-env [ NQDIR $shownThread ] { ^fq }
	} else {
		let shown = (
			$proc
			| parse '{thread}/{process}'
		)
		with-env [
			NQDIR ( $shown.thread.0 | _expandNQ )
		] { ^fq ($shown.process.0) }
	}
}

export def nq [
	--now(-n): bool
	--thread(-t): any
	...args: any
] {

	if ($now) {

		let nqdir = (_getFreeThread)
		NQDIR=$nqdir ^nq nu -c $"( $args | str join ' ' )"
		print $nqdir
	} else if not ($thread | is-empty) {

		let nqdir = ($env.NQDIR | path join $thread)
		NQDIR=$nqdir ^nq nu -c $"( $args | str join ' ' )"
	} else {

		let nqdir = ($env.NQDIR | path join "Main")
		^nq nu -c $"( $args | str join ' ' )"
	}
}

export def "nq clean" [] {

	let active = ( lsq | get name )
	lsq -a
		| get name
		| filter { 
			not $in in $active
		}
		| each { rm $in }
		| ignore

	ls $env.NQDIR
		| get name
		| where { 
			ls $in | is-empty
		}
		| each { rm $in }
		| ignore

}
export def "nq kill" [
	...args: string@_nqActiveProcessesCompletion
] {

}

# input: process lockfiles list
# output: list of commands executed in each process
def "_nqProcessesCommands" [] {

	$in
		| each {
			open $in
			| lines
			| get 0
			| parse "exec nq nu -c '{foo}'"
			| get foo.0
		}
		| wrap description
}

def _nqActiveProcessesCompletion [] {

	fd -t x . $env.NQDIR
		| _nqProcessesCommands
}

def _nqThreads [] {

	fd -d 1 -t d . $env.NQDIR
		| lines
		| where { |it|
			fd -d 1 -t x . $it
				| is-empty
				| invert
		}
		| each { _relpath $env.NQDIR }
}

def _expandNQ [] {

	let child = $in
	$env.NQDIR | path join $child
}

def _getFreeThread [] {

	let freeThreads = (

		fd -d 1 -t d . $env.NQDIR
			| lines
			| where { |it|
				fd -d 1 -t x . $it | is-empty
			}
	)
	if ($freeThreads | length) > 0 {
		$freeThreads.0
	} else {
		$env.NQDIR
			| path join (
				"q" + (random uuid | str substring 0..8)
			)

	}
}
