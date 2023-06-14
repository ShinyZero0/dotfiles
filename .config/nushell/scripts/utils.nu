# get a string with styling applied and resetted ansi
export def ansi-temp [ text: string color: any ] {
	[
		( ansi reset )
		( ansi $color )
		$text
		( ansi reset )
	]
	| str join
}

# get full path relative to homedir
export def Home [ path: string ] {

	$env.HOME
		| path join $path
}

# get file extension
export def _getExt [] {

	path parse
		| get extension
}

# get file without extension
export def _unExt [] {

	path parse
		| reject extension
		| path join
}

export def _isChildOf [ parent: string ] {

	path expand
		| str starts-with ( $parent | path expand )
}

# print clipboard
export def "Clip o" [] {

	to text
	| if not ( which xsel | is-empty ) {
		xsel -ob
	} else {
		termux-clipboard-get
	}
}

# yank to clipboard
export def "Clip i" [] {

	to text
	| if not ( which xsel | is-empty ) {
		xsel -ib
	} else {
		termux-clipboard-set
	}
}
