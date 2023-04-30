def _treeSitterNu [] {

	let file = "highlights.scm"
	let remote = ( "https://raw.githubusercontent.com/nushell/tree-sitter-nu/main/queries/" | path join $file )
	let local = (
	
		$env.XDG_DATA_HOME?
		| default ($env.HOME | path join ".local" "share")
		| path join "nvim" "lazy" "nvim-treesitter" "queries" "nu" $file
	)

	if ( $local | path exists ) { return }
	
	mkdir ( $local | path dirname )
	http get $remote | save $local 
}

_treeSitterNu
