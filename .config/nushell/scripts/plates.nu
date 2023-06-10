def _platesComplete [] {

	let PlatesDir = ( $env.PLATES_DIR? | default $env.HOME )
	ls -a $PlatesDir
	| get name
	| path relative-to $PlatesDir
}

export def plate [
	file: string@_platesComplete,
	--output(-o): any # output filename
] {
	let PlatesDir = ( $env.PLATES_DIR? | default $env.HOME )

	let plate = ( $PlatesDir | path join $file )
	let output = if not ( $output | is-empty ) {
		$output
	} else {
		$env.PWD
	}

	cp $plate $output
}

