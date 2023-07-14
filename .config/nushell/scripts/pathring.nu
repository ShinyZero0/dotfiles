# get file without extension
def un-ext [] {

	path parse
		| reject extension
		| path join
}
alias px = path expand --no-symlink

# manage a filepath list
export def "ring" [] { }

# add paths to ring
export def "ring add" [
	--fuzzy(-f): bool
	...args: any
] {
	let input = $in
	let fuzzyChoice = (

		if $fuzzy {

			fd --no-ignore-vcs -Hd 1 . 
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
		| append $data
		| _writeToRing

	open $ringPath
}

# copy files from ring to $output and clean
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

# delete (physically) files listed in ring and clean it
export def "ring rm" [ ] {

	let ring = ( open (_getRingPath) )
	$ring | each { rm -r $in }
	ring clean
}

# move files from ring to $output and clean
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

# clean the files list
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

# symlink another list to the current, create if doesn't exist
export def "ring switch" [
	name: string@_completeRings
] {
	mkdir "~/.local/share/nushell/rings/"
	let currentRing = (
		"~/.local/share/nushell/rings/"
		| path join $"($name).json"
		| px
	)
	touch $currentRing
	ln -sf ($currentRing) (_getRingPath)
}

def "_completeRings" [] {

	ls ~/.local/share/nushell/rings/**/*.json
		| get name
		| wrap value
		| each { |it|
			upsert description (
				open $it.value | length
				| $"($in) file\(s)"
			)
			| update value {
				path basename | un-ext
			}
		}
}
# list the files
export def "ring ls" [] {
	open (_getRingPath)
}

def "_getRingPath" [] {

	let ringPath = ("~/.local/share/nushell/ring.json" | px)
	if not ($ringPath | path exists) {
		mkdir ~/.local/share/nushell/rings/
		touch ~/.local/share/nushell/rings/main.json
		ln -s ~/.local/share/nushell/rings/main.json ~/.local/share/nushell/ring.json
	}
	$ringPath
}

def _writeToRing [] {
	
	px
	| uniq 
	| save -f (_getRingPath)
}
