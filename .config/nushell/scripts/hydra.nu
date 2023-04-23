let _focusHydraKeys = [ 
	{
		lhs: "o"
		rhs: {|| exec nu -e _open}
		exit: true
	},
	{
		lhs: "s"
		rhs: {|| exec nu -e _select}
		exit: true
	},
	{
		lhs: "f"
		rhs: {|| exec nu -e _focus}
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
			tput rmcup
			do $matchedKey.rhs 
			tput smcup
			if $matchedKey.exit { break }
		}
	} 
	tput rmcup
}
def-env _focusHydra [] {
	hydra $_focusHydraKeys
}
