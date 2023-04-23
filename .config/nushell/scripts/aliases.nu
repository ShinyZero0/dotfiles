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
alias fi = find
alias fii = find -i
alias g = get

def yankfile [] {

	let input = $in
	mut file = ""
	if ($input | describe | str starts-with "record<") {
		$file = $input.name
	} else { 
		$file = $input
	}
	let type = ( file --mime-type $file | split row " " | last )
	xclip -t $type -sel clip $file
}

def desc [] {
	describe | descfmt
}

def share [ file: string ] {
	curl -F $"file=@($file)" https://0x0.st
}

alias dwn = ls ~/Downloads/
alias pic = ls ~/Pictures/
alias latest = sort-by modified
alias xtr = atool -x

alias ru = trans :ru
alias en = trans :en

def ungitb [] {
	xsel -ob | parse 'https://github.com/{match}'
	| get match | to text | xsel -ib
}


