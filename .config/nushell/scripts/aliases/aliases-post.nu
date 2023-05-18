export def l [] {
	ls | sort-by type modified
}


export alias describe_ = describe
export def _describe [] {
	describe_ | descfmt
}
export alias describe = _describe

export alias hm = home-manager
