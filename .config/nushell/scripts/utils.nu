def parse-help [] {

    $in 
	| parse -r '\s\s+(?:-(?P<short>\w)[,\s]+)?(?:--(?P<long>[\w-]+))\s*(?:<(?P<format>.*)>)?\s*(?P<description>.*)?'
}

# def with [func: closure] {
#
# 	let input = $in
# 	$input | $func 
# 	$input
# }

def mvnrp [
	old: string new: string
] {

	mv $old $new
	let files = ( fd | lines  )
	for file in $files {
		if ( $file | path parse | get extension ) == "nu" and (
			$env.NU_LIB_DIRS | any { ||
				(
					$old | path expand | str starts-with ( $in | path expand )
				) and (
					$new | path expand | str starts-with ( $in | path expand )
				)
			}
		) {
			sd $"\(source|use) ($old | path basename)" $'$1 ($new | path basename)' $file
		}

		sd ( $old | path expand ) ( $new | path expand ) $file
		# sd (
		# 	$old | path relative-to $env.PWD
		# ) (
		# 	$new | path relative-to $env.PWD
		# ) $file
	}
}
