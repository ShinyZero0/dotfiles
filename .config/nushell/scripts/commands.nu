use utils.nu *

export def clip [ arg? ] {

	let input = ( $in | default $arg )
	if ( $input | is-empty ) {
		_clip o
	} else {
		$input | _clip i
	}
}
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
	| parse -r '\s\s+(?:-(?P<short>\w)[,\s]+)?(?:--(?P<long>[\w-]+))\s*(?:<(?P<format>.*)>)?\s*(?P<description>.*)?' | format "--{long}(-{short})\t# {description}" | to text 
}

export def-env root [ num: int ] {
	for i in 1..$num {
		cd ..
	}
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

export def to-do [] {
	rg -C 1 '^[-/*# \t]*TODO' ~/.config/ ~/dev ~/.scripts/ ~ --ignore-file ~/.gitignore 
}

export def ghraw-b [] {
	ungit-b;
	[
		"https://raw.githubusercontent.com",
		(
			_clip o 
			| path split 
			| where { || $in != "blob"  }
		)
	] 
	| flatten 
	| path join
}

def _platesComplete [] {

	let PlatesDir = ( $env.PLATES_DIR? | default $env.HOME )
	ls -a $PlatesDir
	| get name 
	| path relative-to $PlatesDir
}

export def plate [ ...args: string@_platesComplete ] {
	
	let PlatesDir = ( $env.PLATES_DIR? | default $env.HOME )
	for file in $args {
		cp ( $PlatesDir | path join $file ) $env.PWD
	}
}

export def gcf [] {
	
	let file = (
		git rev-parse --show-toplevel 
		| str trim 
		| path join .commit-msg.txt
	)
	git commit -F $file
	"" | save -f $file
}
export def gcfe [] {
	
	let file = (
		git rev-parse --show-toplevel 
		| str trim 
		| path join .commit-msg.txt
	)
	run-external $env.EDITOR $file
}
