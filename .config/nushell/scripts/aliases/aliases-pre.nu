# old alias for competion
old-alias pkin = sudo xbps-install
old-alias pkrm = sudo xbps-remove
use utils.nu [ "_clip o" "_clip i" ]
alias pkup = sudo xbps-install -SAu
alias pkfd = xbps-query -Rs
alias pkls = xbps-query -m

old-alias dn = dotnet

alias vi = nvim

alias q = exit
alias r = exec nu
alias fi = find
alias fii = find -i
alias g = get

def yankfile [] {

	let input = $in
	mut file = ""
	if (
		$input | describe | str starts-with "record<"
	) {
		$file = $input.name
	} else { 
		$file = $input
	}
	let type = (
		file --mime-type $file | split row " " | last
	)
	xclip -t $type -sel clip $file
}
alias yf = yankfile

# TODO: universal clipboard 
def share [ file: string ] {
	curl -F $"file=@($file)" https://0x0.st | xsel -ib
	print "Link copied to clipboard!"
}

alias dwn = ls ~/Downloads/
alias pic = ls ~/Pictures/
alias latest = sort-by modified
alias xtr = atool -x

alias ru = trans :ru
alias en = trans :en

def ungitb [] {

	_clip o | parse 'https://github.com/{match}'
	| get match 
	| to text 
	| _clip i
}

def __platesComplete [] {

	let PlatesDir = ( $env.PLATES_DIR? | default $env.HOME )
	ls -a $PlatesDir
	| get name 
	| path relative-to $PlatesDir
}
def plate [ ...args: string@__platesComplete ] {
	
	let PlatesDir = ( $env.PLATES_DIR? | default $env.HOME )
	for file in $args {
		cp ( $PlatesDir | path join $file ) $env.PWD
	}
}

def lns [
	source: string 
	dest: string
] {
	ln -s ( $source | path expand ) ( $dest | path expand )
}
