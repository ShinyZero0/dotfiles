let _focusHydraKeys = [ 
	{
		lhs: "o"
		rhs: {|| _open; $env }
		exit: true
	},
	{
		lhs: "s"
		rhs: {|| _select; $env }
		exit: true
	},
	{
		lhs: "f"
		rhs: {|| _focus; $env }
		exit: true
	},
	{
		lhs: "q"
		rhs: {|| }
		exit: true
	}
]
def-env hydra [
	keydefs: list<record>
] {
	tput smcup
	while true {
		let key = ( readkey -b )
		clear
		let matchedKeys = ( $keydefs | where lhs == $key )
		mut matchedKey = {}
		if ( $matchedKeys | is-empty ) {
			print $"Undefined key: ($key)"
		} else {
			$matchedKey = $matchedKeys.0
			do $matchedKey.rhs | load-env
			if $matchedKey.exit { break }
		}
	} 
	tput rmcup
}
def-env _focusHydra [] {
	hydra $_focusHydraKeys
}
