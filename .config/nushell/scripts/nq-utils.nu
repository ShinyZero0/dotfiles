use pipes.nu [
	"invert"
]
def "_nqDir" [] {

	$env.HOME
	| path join .stuff/nq
}

# list enqueued processes
export def "nq ls" [] {

	fd -t x . (_nqDir)
		| lines
		| wrap name
		| merge ($in.name | _nqProcessesCommands)
		| merge ($in.name | _nqProcessesModtime)
		| sort-by modified
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
	if ($thread | is-empty) {
		$env.NQDIR = (_getFreeThread)
	} else {
		$env.NQDIR = ($thread | _expandNQ)
	}
	print $env.NQDIR

	if $sudo {
		let pass = (input "Password:\n")
		^nq bash -c $"echo $pass | exec sudo -S nu -c ( $args | str join ' ' )"
	} else {
		^nq nu -c $"( $args | str join ' ' )"
	}

	if $clean {
		^nq rm -r $env.NQDIR
	}
}

export def "nq clean" [] {

	error make { msg: "Dangerous to use" }
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
	error make { msg: "Not implemented!" }
}

# input: process lockfiles list
# output: their modified times list
def _nqProcessesModtime [] {

	par-each { ls $in }
		| flatten
		| select modified
}

# input: process lockfiles list
# output: list of commands executed in each process
def "_nqProcessesCommands" [] {

	par-each {
		open $in
		| lines
		| get 0
	}
	| wrap description
}

def _nqActiveProcessesCompletion [] {

	fd -t x . $env.NQDIR
		| _nqProcessesCommands
}

def _nqThreads [] {

	fd -d 1 -t d . (_nqDir)
		| lines
		| where { |it|
			fd -d 1 -t x . $it
				| is-empty
				| invert
		}
		| each { path relative-to (_nqDir) }
}

def _expandNQ [] {

	let child = $in
	_nqDir | path join $child
}

def _getFreeThread [] {

	let freeThreads = (

		fd -d 1 -t d . (_nqDir)
			| lines
			| where { |it|
				fd -d 1 -t x . $it | is-empty
			}
	)
	if ($freeThreads | length) > 0 {
		$freeThreads.0
	} else {
		_nqDir
		| path join (
			"q" + (random uuid | str substring 0..8)
		)
	}
}
