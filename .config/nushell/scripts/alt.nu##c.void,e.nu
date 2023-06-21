use utils.nu Home
export use xbps-cmp.nu *
export def-env "AltEnv" [] {
	
	let-env PAGER = ov
	let-env MANPAGER = ov
	let-env SVDIR = ( Home '.local/share/service' )
}

