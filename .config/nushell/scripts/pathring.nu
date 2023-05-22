# add paths to ring
export def "ring add" [
	--fuzzy(-f): bool
	...args: any
] {

	let input = $in
	let fuzzyChoice = ( 

		if $fuzzy {

			fd --no-ignore-vcs -Hd 4 . 
			| fzf --scheme path --multi
			| lines
		}
	)
	let data = (

		try {
			$input | get name
		} catch {
			$input
		}
		| append $args
		| append $fuzzyChoice
	)

	let ringPath = (_getRingPath)
	open $ringPath
		| append ( $data | path expand )
		| save -f $ringPath

	open $ringPath
}

export def "ring cp" [
	output: any
	--preserve(-p): bool = false
] {

	open (_getRingPath)
		| each {
			cp -r $in $output
		}

	if not $preserve {
		ring clean
	}
}

export def "ring rm" [ ] {

	let ring = ( open (_getRingPath) )
	$ring | each { rm -r $in }
	ring clean
}

export def "ring mv" [
	output: any
	--preserve(-p): bool = false
] {

	let ring = ( open (_getRingPath) )
	for path in $ring {
		mv $path $output
	}

	if not $preserve {
		ring clean
	}

}

export def "ring clean" [
	--fuzzy(-f): bool
] {
	let ringPath = (_getRingPath)
	if $fuzzy {

		let toRemove = (

			open $ringPath
				| to text
				| fzf --scheme path --multi
				| lines
		)
		open $ringPath 
			| where {not $in in $toRemove}
			| save -f $ringPath

		open $ringPath

	} else {
		rm $ringPath
	}
}

export def "ring ls" [] {
	open (_getRingPath)
}

def "_getRingPath" [] {

	let ringPath = ("~/.local/share/nushell/ring.nuon" | path expand)
	if not ($ringPath | path exists) {
		touch $ringPath
	}
	$ringPath
}
