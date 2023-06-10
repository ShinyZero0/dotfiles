use utils.nu *
use nq-utils.nu *
use std "assert error"

export def "edpipe" [] {

	let input = $in

	try {
		$input 
		| check-string | vipe
	} catch {
		$input | to nuon -t 1
		| vipe --suffix=nu 
		| from nuon
	}
	| str trim

}
export def check-string [] {

	let obj = $in
	assert error { || $obj | columns }
	$obj
}
export def clip [ arg? ] {

	let input = ( $in | default $arg )
	if ( $input | is-empty ) {
		_clip o
	} else {
		$input | _clip i
	}
}

export def "tempclip" [] {
	_clip i 
	nq -t tempclip "use utils.nu *; sleep 1min; '' | _clip i"
}

export def indexate [] {
	$in | enumerate | flatten
}

# list runit services
export def svls [
	--all(-a)
	--root(-r)
] {
	if $all {

		if $root {
			ls /etc/sv/
		} else {
			ls ~/.config/sv/
		}
	} else {

		if $root {
			ls /var/service/
		} else {
			ls $env.SVDIR
		}
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

	parse -r '\s\s+(?:-(?P<short>\w)[,\s]+)?(?:--(?P<long>[\w-]+))\s*(?:<(?P<format>.*)>)?\s*(?P<description>.*)?'
		| format "--{long}(-{short})\t# {description}"
		| to text
}

export def json2snip [] {
	$in | format "snippet {prefix} '{description}'\n\t{body}"
}

export def ungit-b [ --short(-s): bool ] {

	if ( not ( _clip o | str contains 'https://github.com/' ) ) { return }

	_clip o 
	| parse 'https://github.com/{match}'
	| get match 
	| to text
	| _clip i
}
export def "peacemaker" [] {

	git diff --name-only --diff-filter=U
	| lines
	| each { |f|
		ignore; nvim $f
	}
}

export def to-do [] {
	rg -C 1 '^[-/*# \t]*TODO' ~/.config/ ~/dev ~/.scripts/ --ignore-file ~/.gitignore
}

export def ghraw-b [] {

	ungit-b;
	[
		"https://raw.githubusercontent.com",
		(
			_clip o
			| path split
			| where { $in != "blob"  }
		)
	]
	| flatten
	| path join
}

# commit with a message from file
export def gcf [] {

	let file = (
		git rev-parse --show-toplevel
			| str trim
			| path join .commit-msg.txt
	)
	git commit -F $file

	"" | save -f $file
}

# edit the commit message file
export def gcfe [] {

	let file = (
		git rev-parse --show-toplevel
		| str trim
		| path join .commit-msg.txt
	)
	run-external $env.EDITOR $file
}

export def "cat <<" [ eof ] {

	mut out = []
	while true {

		let line = (input)
			if ($line == $eof) {
				break
			} else {
				$out = ( $out | append $line )
			}
	}
	return $out
}

# take first element to match the closure condition
export def First [ func: closure default?: any ] {
	# TODO: the "default" doesn't work actually
	where {do $func } | first
}

export def "to qr" [] {
	qrencode -t utf8 ( $in | to text )
}
