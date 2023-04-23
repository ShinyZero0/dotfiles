# old alias for competion
old-alias pkin = sudo xbps-install
old-alias pkrm = sudo xbps-remove
alias pkup = sudo xbps-install -SAu
alias pkfd = xbps-query -Rs
alias pkls = xbps-query -m

old-alias dn = dotnet

# list runit services
alias svls = ls /var/service/
# and available ones
alias svlsav = ls /etc/sv/

alias ga = git add
alias gc = git commit -m
alias gd = git diff
alias gds = git diff --staged
alias gst = git status
alias gcl = git clone
alias gca = git commit -am
old-alias gch = git checkout
alias grm = git rm --cached
alias gcl1 = git clone --depth 1
alias grss = git restore --staged

alias yd = yadm enter nu
alias vi = nvim

alias q = exit
alias r = exec nu
alias fi = find -i
alias f = find
alias g = get

def-env _focus [] {

	let out = ( fd -Hd 5 | fzf | complete )
	if out.exit_code != 0 { return }
	let obj = out.stdout
	if ($obj | path type) == dir {
		z $obj
	} else {
		z ( $obj | path dirname )
		ls ( $obj | path basename )
	}
}
alias t = _focus

def _describe [] {
	describe | descfmt
}
alias describe = _describe

def share [ file: string ] {
	curl -F $"file=@($file)" https://0x0.st
}

alias xtr = atool -x

alias ru = trans :ru
alias en = trans :en

def _ungitb [] {
	xsel -ob | parse 'https://github.com/{match}'
	| get match | to text | xsel -ib
}
alias ungitb = _ungitb


