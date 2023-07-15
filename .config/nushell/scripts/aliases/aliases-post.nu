export def l [ dir? = . ] {
	ls $dir | sort-by modified
}


def _describe [] {
	describe | descfmt
}

export alias dscr = _describe
export alias yf = yankfile
