use utils.nu Home
export use xbps-cmp.nu *
export def-env "AltEnv" [] {
	
	let-env SVDIR = ( Home '.local/share/service' )
	mkdir $env.SVDIR
}

