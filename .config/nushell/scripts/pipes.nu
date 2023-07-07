# filters and other stuff that should be | between pipes |
use utils.nu *

export def indexate [] {
	enumerate | flatten
}

# well, invert
export def invert [] {

	let value = $in
	if $value { false } else { true }
}

# get file without extension
export def un-ext [] {

	path parse
		| reject extension
		| path join
}

# get file extension
export def get-ext [] {

	path parse
		| get extension
}

# check if the path is a child of another path
export def is-child-of [ parent: string ] {

	path expand
		| str starts-with ( $parent | path expand )
}

# take first element to match the closure condition
export def First [ func: closure default?: any ] {
	# TODO: the "default" doesn't work actually
	where {do $func} | first
}

