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
