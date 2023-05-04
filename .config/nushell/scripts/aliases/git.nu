export alias yd = yadm enter nu

export alias ga = git add
export alias gc = git commit -m
export alias gd = git diff
export alias gds = git diff --staged
export alias gst = git status
export alias gcl = git clone
export alias gca = git commit -am
export alias gch = git checkout
export alias grm = git rm --cached
export alias gcl1 = git clone --depth 1
export alias grss = git restore --staged
export def gls [] {
	
	git ls-tree --full-tree --name-only -r HEAD | lines
}
