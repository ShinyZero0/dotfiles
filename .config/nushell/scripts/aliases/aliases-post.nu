def l [] {
	ls | sort-by type modified
}

def _describe [] {
	describe | descfmt
}

alias desc_ = describe
alias describe = _describe
