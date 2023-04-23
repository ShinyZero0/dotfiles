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
def yankfile [ file: string ] {

	if not ( $in | is-empty ) {
		let file = $in
	}
	let type = ( file --mime-type $file | split row " " | last )
	xclip -t $type -sel clip $file
}

# def _openWith [ file: string ] {
# 	let handlers = [ "nvim" "nomacs" "paste" ]
# 	let hand = ( $handlers | to text | fzf --exact --height 50% --cycle --bind=tab:down,btab:up --reverse )
# 	nu -c $"($hand) ($file)"
# }

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


