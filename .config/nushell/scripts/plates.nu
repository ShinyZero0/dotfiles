def _platesComplete [] {

	let PlatesDir = ( $env.PLATES_DIR? | default $env.HOME )
	ls -a $PlatesDir
	| get name 
	| path relative-to $PlatesDir
}

export def plate [
	file: string@_platesComplete,
	--license(-l): bool # if output is license
	--description(-d); any # package description for license
	--output(-o): any # output filename
] {
	let PlatesDir = ( $env.PLATES_DIR? | default $env.HOME )
	
	let plate = ( $PlatesDir | path join $file )
	let output = (

		if $license {
			"LICENSE"
		} else if not ( $output | is-empty ) {
			$output
		} else {
			$env.PWD
		}
	)
	if $license {
		
		open $plate 
			| str replace -as "<description>" ( $description | default "Cool software" )
			| str replace -as "<year>" ( date now | date format "%Y" )
			| save $output

		return
	}

	cp $plate $output
}

