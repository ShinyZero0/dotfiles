def l [] {
	ls | sort-by type modified
}

def _describe [] {
	describe | descfmt
}

alias describe_ = describe
alias describe = _describe

alias hm = home-manager
