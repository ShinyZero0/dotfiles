use choose.nu funcs
overlay use funcs
use pipes.nu First

# get command usage
def "get-usage" [ command ] {

	scope commands
		| First {$in.name == $command}
		| get usage
}
let ChoooserHydraKeys = [

	{
		lhs: "o"
		rhs: { _open }
		exit: true
		desc: (get-usage _open)
	},
	{
		lhs: "s"
		rhs: { _select }
		exit: true
		desc: (get-usage _select)
	},
	{
		lhs: "f"
		rhs: { _focus }
		exit: true
		desc: (get-usage _focus)
	},
	{
		lhs: "q"
		rhs: { || }
		exit: true
		desc: "quit"
	},
	{
		lhs: "ESC"
		rhs: { || }
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

def-env ChoooserHydra [] {
	hydra $ChoooserHydraKeys
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
