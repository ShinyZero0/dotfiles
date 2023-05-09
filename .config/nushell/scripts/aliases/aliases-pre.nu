# old alias for competion
# TODO: turn into module
use utils.nu [ "_clip o" "_clip i" ]

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

def share [ file: string ] {
	curl -F $"file=@($file)" https://0x0.st | _clip i
	print "Link copied to clipboard!"
}

alias dwn = ls ~/Downloads/
alias pic = ls ~/Pictures/
alias recent = sort-by modified
def latest [] {
	$in | recent | last
}
alias xtr = atool -x

alias ru = trans :ru
alias en = trans :en

def lns [
	source: string 
	dest: string
] {
	ln -s ( $source | path expand ) ( $dest | path expand )
}
