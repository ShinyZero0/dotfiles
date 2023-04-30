
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
	find: string replace: string ...files: string
] {
	for file in $files {
		open $file | str replace -a $find $replace | save -f $file
	}
}

