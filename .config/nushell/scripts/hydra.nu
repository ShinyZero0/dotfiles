use choose.nu funcs
overlay use funcs
let _finderHydraKeys = [

	{
		lhs: "o"
		rhs: { _open }
		exit: true
		desc: "open file without focusing"
	},
	{
		lhs: "s"
		rhs: { _select }
		exit: true
		desc: "open file or copy dir to clipboard"
	},
	{
		lhs: "f"
		rhs: { _focus }
		exit: true
		desc: "focus and open file"
	},
	{
		lhs: "q"
		rhs: { }
		exit: true
		desc: "quit"
	}
]
def-env hydra [
	keydefs: list<record>
] {

	# let hint = ( _makeHint $keydefs | to text )
	let hint = ( $keydefs | select lhs desc )
	print $hint
	while true {

		let key = ( readkey -b )
		# print $hint
		let matchedKeys = ( $keydefs | where lhs == $key )
		mut matchedKey = { }
		if ( $matchedKeys | is-empty ) {

			let warn = $"(ansi lrb)Undefined key: ($key)(ansi reset)"
			print ( $warn )
		} else {

			$matchedKey = $matchedKeys.0
			export-env $matchedKey.rhs 
			if $matchedKey.exit { break }
		}
	}
}

def-env _finderHydra [] {
	hydra $_finderHydraKeys
}

# unused

# def _makeHint [
# 	keydefs: list<record>
# ] {
# 	mut hintStrings = []
# 	for keydef in $keydefs {
# 		let keyColor = (
# 			if $keydef.exit {
# 				"ub"
# 			} else {
# 				"pb"
# 			}
# 		)
# 		let str = $"(ansi $keyColor)($keydef.lhs): (ansi g)($keydef.desc)"
# 		$hintStrings = (
# 			$hintStrings | append ( $str )
# 		)
# 	}
# 	$hintStrings | append (ansi reset)
# }

# def _centerLine [
# 	line: string
# ] {
# 	$line | fill -a m -c " " -w (
# 		(
# 			(term size | get columns) / 2 | into int
# 		) + ($line | str length)
# 	)
# }
