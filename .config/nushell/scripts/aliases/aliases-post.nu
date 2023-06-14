export def l [] {
	ls
	| sort-by type modified
}


def _describe [] {
	describe | descfmt
}

export alias dscr = _describe
export alias yf = yankfile
