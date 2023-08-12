use utils.nu *
use pipes.nu *
use std "assert"

export def "clipped" [ ft: any ] {
	Clip o | vipe --suffix $ft | Clip i
}

use pathring.nu *
# play the selected files in mpv
export def "ring play" [
    --shuffle(-s) 
] {
    if $shuffle {
        mpv --shuffle --no-video (ring ls)
    } else {
        mpv --no-video (ring ls)
    }
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

use nq-utils.nu *
# copy to clipboard and clean it 1 minute later
export def "clip-temp" [] {

	Clip i
	rm -rpf ~/.stuff/nq/clip-temp
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

# list runit services
export def svls [
	--all(-a) # list currently disabled ones
	--root(-r) # list system-wide services
] {
	if $all {

		if $root {
			ls "/etc/sv/"
		} else {
			ls "~/.config/sv/"
		}
	} else {

		if $root {
			ls "/var/service/"
		} else {
			ls "~/.local/share/service/"
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

	let gitroot = (git rev-parse --show-toplevel)
	nvim (
		git diff --name-only --diff-filter=U
		| lines
		| each { |it|
			$gitroot
			| str trim
			| path join $it
		}
	)
}
export def "patchmaker" [ dir = . ] {
	
	let gitroot = (git rev-parse --show-toplevel)
	nvim (
		git diff --name-only $dir
		| lines
		| each { |it|
			$gitroot
			| str trim
			| path join $it
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

export def "save-temp" [ extension? ] {
	
	let input = $in
	let file = (mktemp $"nu-tempXXXXXX(
		$".($extension)"
		| match $in {
			"." => "",
			_ => $in
		}
	)" --tmpdir)
	$input | save -f $file
	print $file
}
export def "get-pics" [ url: string out?: string = "." ] {
	
	wget --accept jpg,jpeg,png --recursive --no-directories -P $out $url
}
export def "order-files" [ dir? = ".", by? = modified ] {
	
	cd $dir
	ls
	| where type == file
	| sort-by $by
	| get name
	| indexate
	| each { |it|
		mv -f $it.item $"(
			sha256sum $it.item | split row -r '\s+' | get 0
		)(
			$".($it.item | get-ext)"
			| match $in {
				"." => "",
				_ => $in
			}
		)"
	}

	ls
	| where type == file
	| sort-by $by
	| get name
	| indexate
	| each { |it|
		mv $it.item $"($it.index)(
			$".($it.item | get-ext)"
			| match $in {
				"." => "",
				_ => $in
			}
		)"
	}
}

export def "hell" [ program query? ] {

	^$program --help
		| if ($query | is-empty) {
			bat -l help --paging always
		} else {
			rg --context 3 -- $query
			| bat -l help --paging always
		}
}

# Like which but outputs only one string - the path
export def "witch" [ program: string ] {
	which $program | get 0.path
}

export def "yankpath" [ file ] {
	$file | path expand | Clip i
}
# pack directory as comic book tar+gzip archive
export def "cbr" [ dir ] {
	tar --create --gzip --file $"($dir | path basename).cbr" $"($dir)/*"
}
export def "pr" [] {
	let input = $in
	print $input
	$input
}
export def "loc" [ dir = .] {
	ls $dir
	| where type == file
	| select name
	| each { |it|
		upsert count (
			open --raw $it.name
			| lines
			| length
		)
	}
	| pr
	| get count
	| math sum
	| $"Total: ($in)"
}

export def "fint" [ query: string path? ] {

	if ($path | is-empty) {
		filter { str contains $query }
	} else {
		filter { get $path | str contains $query }
	}
		
}
export def "path ensure" [ --root(-r) ] {
	let file = $in
	if $root {
		sudo mkdir -p ($file | path expand | path dirname)
	} else {
		mkdir ($file | path expand | path dirname)
	}
	$file
}
