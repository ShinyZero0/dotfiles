# add paths to ring
export def "ring add" [ ...args: any ] {

	let input = $in
	let data = (
		try {
			$input | get name
		} catch {
			$input
		}
		| append $args
	)

	let ringPath = (_getRingPath)
	open $ringPath
		| append ( $data | path expand )
		| save -f $ringPath

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

export def "ring clean" [] {
	rm (_getRingPath)
}

export def "ring ls" [] {
	open (_getRingPath)
}

def "_getRingPath" [] {

	let ringPath = ("~/.local/share/nushell/ring.json" | path expand)
	if not ($ringPath | path exists) {
		touch $ringPath
	}
	$ringPath
}
