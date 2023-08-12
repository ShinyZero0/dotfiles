use std clip

# get a string with styling applied and resetted ansi
export def ansi-temp [ text: string color: any ] {
	[
		( ansi reset )
		( ansi $color )
		$text
		( ansi reset )
	]
	| str join
}

# get full path relative to homedir
export def Home [ path: string ] {

	$env.HOME
		| path join $path
}

# print clipboard
export def "Clip o" [] {

	to text
	| if not ( which xsel | is-empty ) {
		xsel --output --clipboard
	} else {
		termux-clipboard-get
	}
}

# yank to clipboard
export def "Clip i" [] {
	to text | clip
}

def "ensure" [file] {
	mkdir ($file | path expand | path dirname)
}
