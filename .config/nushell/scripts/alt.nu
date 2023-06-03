if (uname -m) == "aarch64" {

	$env.config.rm.always_trash = false
	$env.PATH = ( $env.PATH 
		| prepend ( 
			$env.HOME 
			| path join ".local/bin" 
		)
		| prepend ( 
			$env.HOME 
			| path join ".local/share/zinit/polaris/bin" 
		)
	)
	$env.PAGER = less
	$env.MANPAGER = less
	hide-env SVDIR
}
export def "pkg browse" [ pkg: string@"termux pkg all" ] {

	pkg info $pkg
		| lines
		| get 4
		| parse 'Homepage: {url}'
		| get url
		| xdg-open $in
}

def "termux pkg all" [] {

    open ~/.cache/pkg-all.json
}
