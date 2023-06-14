use utils.nu *
use nq-utils.nu *
use std "assert"

export def "clipped" [ ft: any ] {
	Clip o | vipe --suffix $ft | Clip i
}
export def "edpipe" [] {

	let input = $in

	try {

		$input
			| assert string
			| vipe
	} catch {

		$input
			| to nuon -t 1
			| vipe --suffix=nu
			| from nuon
	}
	| str trim

}
export def "assert string" [] {

	let obj = $in
	assert ($obj | describe | str starts-with "string")
	$obj
}

export def clip [ arg? ] {

	let input = ( $in | default $arg )
	if ( $input | is-empty ) {
		Clip o
	} else {
		$input | Clip i
	}
}

export def "clip-temp" [] {
	Clip i
	nq -t clip-temp "use utils.nu *; sleep 1min; '' | Clip i"
}

export def yankfile [] {

	let input = $in
	let file = (

		try {
			$input.name
		} catch {
			$input
		}
	)
	let type = (

		file --mime-type $file
			| split row " "
			| last
	)
	xclip -t $type -sel clip $file
}

export def indexate [] {
	enumerate | flatten
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

# get user/repo from github url
export def ungit-cb [ --short(-s): bool ] {

	if ( not ( Clip o | str contains 'https://github.com/' ) ) { return }

	Clip o
		| $"($in)/"
		| parse '{rest}github.com/{user}/{repo}/{rest}'
		| into record
		| get user repo
		| path join
		| to text
		| Clip i
}
# resolve conflicts
export def "peacemaker" [] {

	nvim (
		git diff --name-only --diff-filter=U
		| lines
		| if $env.IS_YADM {
			each { |it|
				$env.HOME | path join $it
			}
		}
	)
}

export def to-do [] {
	rg -C 1 '^[-/*# \t]*TODO' ~/.config/ ~/dev ~/.scripts/ --ignore-file ~/.gitignore
}

export def ghraw-b [] {

	ungit-cb;
	[
		"https://raw.githubusercontent.com",
		(
			Clip o
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

# link full path
export def lns [
	source: string
	dest: string
] {
	ln -s ( $source | path expand ) ( $dest | path expand )
}

export def-env "mkcd" [ dir ] {
	
	let dir = (
		$dir | into string
	)
	mkdir $dir
	cd $dir
}
export def share [ file: string ] {

	let link = (
		curl -F $"file=@($file)" https://0x0.st
	)
	$link | Clip i
	print $"Link ($link) copied to clipboard!"
}

