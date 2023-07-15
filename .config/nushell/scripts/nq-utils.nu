use pipes.nu [
	"invert"
]

# list enqueued processes
export def "nq ls" [] {

	fd -t x . $env.NQDIR
		| lines
		| wrap name
		| merge ($in.name | _nqProcessesCommands)
		| merge ($in.name | _nqProcessesModtime)
		| sort-by modified
}
# input: process lockfiles list
# output: their modified time list
def _nqProcessesModtime [] {

	each { ls $in }
		| flatten
		| select modified
}

# see the enqueued process output
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

# Enqueue
export def nq [
	--sudo(-s): bool # if should run command as root
	--clean(-c): bool
	--thread(-t): any
	...args: any
] {

	# TODO: make a sudo flag to prompt for password
	if not ($thread | is-empty) {
		$env.NQDIR = ($env.NQDIR | path join $thread)
	} else {
		$env.NQDIR = (_getFreeThread)
	}

	if $sudo {
		let pass = (input "Password:\n")
		^nq echo $pass | sudo -S nu -c $"( $args | str join ' ' )"
	} else {
		^nq nu -c $"( $args | str join ' ' )"
	}
	print $env.NQDIR

	if $clean {
		^nq sh -c $"rm -r ($env.NQDIR)"
	}
}

export def "nq clean" [] {

	fd -t f . $env.NQDIR
		| lines
		| filter {

			ls -l $in
			| first
			| get mode
			| str contains "x"
			| invert
		}
		| each { |f|
			rm -r ( $f | path dirname );
			print $"Removed ($f)"
		}
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
		| each { path relative-to $env.NQDIR }
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
