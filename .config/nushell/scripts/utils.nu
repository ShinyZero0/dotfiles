
export def ansi-tmp [ text: string color: string  ] {
	[
		( ansi $color )
		$text
		( ansi reset )
	]
	| str join
}
export def _home [ path: string ] {
	
	$env.HOME | path join $path
}
export def getext [] {
	$in | path parse | get extension
}
export def relpath [ parent: string ] {
	$in | path expand | path relative-to ( $parent | path expand )
}
export def is-child-of [ parent: string ] {
	$in | path expand | str starts-with ( $parent | path expand )
}

export def parse-help [] {

    $in 
	| parse -r '\s\s+(?:-(?P<short>\w)[,\s]+)?(?:--(?P<long>[\w-]+))\s*(?:<(?P<format>.*)>)?\s*(?P<description>.*)?'
}

export def fnrfiles [
	find: string 
	replace: string 
	...files: string
] {
	for file in $files {
		open $file 
		| str replace -a $find $replace 
		| save -f $file
	}
}

export def currentfile [] {

	^ps $nu.pid | lines 
	| skip 1 | split row " " 
	| where { ||
		not ($in | is-empty)
	} 
	| get 5
	| path expand
}

export def index [] {
	$in | enumerate | flatten
}
