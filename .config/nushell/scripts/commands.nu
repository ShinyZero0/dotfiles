export def indexate [] {
	$in | enumerate | flatten
}

# list runit services
export def svls [
	--all(-a)
] {
	if $all {
		ls /etc/sv/
	} else {
		ls /var/service/
	}
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

export def-env root [ num: int ] {
	for i in 1..$num {
		cd ..
	}
}
