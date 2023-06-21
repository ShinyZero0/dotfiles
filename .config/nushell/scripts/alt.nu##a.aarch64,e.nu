use utils.nu Home
export use termux-pkg-cmp.nu *
export def-env AltEnv [] {
	$env.config.rm.always_trash = false
	$env.PATH = (
		$env.PATH
		| prepend (
			Home ".local/bin"
		)
		| prepend (
			Home ".local/share/zinit/polaris/bin"
		)
	)
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
