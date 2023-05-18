export def "rnm" [ file: any ] {
	
	let output = (
		gum input --value $file --header "Rename"
		| complete
	)
	if $output.exit_code == 0 {
		mv $file ( $output.stdout | str trim )
	}
}
