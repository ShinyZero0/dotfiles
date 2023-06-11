# old alias for competion
# TODO: turn into module
use utils.nu [ "_clip o" "_clip i" ]
export alias dn = dotnet

export alias vi = nvim

export alias q = exit
export alias r = exec nu

export alias ll = ls --long
export alias la = ls --all

export alias fi = find
export alias fii = find -i
# export alias g = get

export def yankfile [] {

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
export alias yf = yankfile

export def share [ file: string ] {
	curl -F $"file=@($file)" https://0x0.st | _clip i
	print "Link copied to clipboard!"
}

export alias dwn = ls ~/Downloads/
export alias pic = ls ~/Pictures/
export alias recent = sort-by modified
export def latest [] {
	$in | recent | last
}
export alias xtr = atool -x

export alias ru = trans :ru
export alias en = trans :en

export def lns [
	source: string 
	dest: string
] {
	ln -s ( $source | path expand ) ( $dest | path expand )
}
