let _focusHydraKeys = [ 
	{
		lhs: "o"
		rhs: {|| exec nu -e _open}
		exit: true
		desc: "open file without focusing"
	},
	{
		lhs: "s"
		rhs: {|| exec nu -e _select}
		exit: true
		desc: "open file or copy dir to clipboard"
	},
	{
		lhs: "f"
		rhs: {|| exec nu -e _focus}
		exit: true
		desc: "focus and open file"
	},
	{
		lhs: "q"
		rhs: {|| }
		exit: true
		desc: "quit"
	}
]
def-env hydra [
	keydefs: list<record>
] {
	tput smcup
	let hint = ( _makeHint $keydefs | to text )
	print $hint
	while true {
		let key = ( readkey -b )
		clear
		print $hint
		let matchedKeys = ( $keydefs | where lhs == $key )
		mut matchedKey = {}
		if ( $matchedKeys | is-empty ) {
			let warn = $"(ansi lrb)Undefined key: ($key)(ansi reset)"
			print ( $warn | fill -a center -c " " -w (
					(
						(term size | get columns) / 2 | into int
					) + ($warn | str length)
				) )
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
def _makeHint [
	keydefs: list<record>
] {
	mut hintStrings = []
	for keydef in $keydefs {
		let keyColor = (
			if $keydef.exit {
				"ub"
			} else {
				"pb"
			}
		)
		let str = $"(ansi $keyColor)($keydef.lhs): (ansi g)($keydef.desc)"
		$hintStrings = (
			$hintStrings | append (
				$str | fill -a center -c " " -w (
					(
						(term size | get columns) / 2 | into int
					) + ($str | str length)
				)
			)
		)
	} 
	$hintStrings | append (ansi reset)
}
