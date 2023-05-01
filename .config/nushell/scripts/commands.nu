export def indexate [] {
	$in | enumerate | flatten
}

export def fnr_files [
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

export def parse-help [] {

    $in 
	| parse -r '\s\s+(?:-(?P<short>\w)[,\s]+)?(?:--(?P<long>[\w-]+))\s*(?:<(?P<format>.*)>)?\s*(?P<description>.*)?'
}
