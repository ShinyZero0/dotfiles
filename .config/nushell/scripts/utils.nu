export def _ansiTmp [ text: string color: any  ] {
	[
		( ansi reset )
		( ansi $color )
		$text
		( ansi reset )
	]
	| str join
}
export def _home [ path: string ] {
	$env.HOME | path join $path
}
export def _getExt [] {
	$in | path parse | get extension
}
export def _relpath [ parent: string ] {
	$in | path expand | path relative-to ( $parent | path expand )
}
export def _isChildOf [ parent: string ] {
	$in | path expand | str starts-with ( $parent | path expand )
}

export def _currentfile [] {

	^ps $nu.pid 
		| lines 
		| skip 1 | split row " " 
		| where { ||
			not ($in | is-empty)
		} 
		| get 5
		| path expand
}
export def "_clip o" [] {

	if not ( which xsel | is-empty ) {
		xsel -ob
	} else {
		termux-clipboard-get
	}
}
export def "_clip i" [] {

	if not ( which xsel | is-empty ) {
		$in | xsel -ib
	} else {
		termux-clipboard-set
	}
}
export def invert [] {

	let value = $in
	if $value { false } else { true }
}
