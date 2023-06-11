# old alias for competion
# TODO: turn into module
use utils.nu [ "_clip o" "_clip i" ]
alias dn = dotnet

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

alias ru = trans en:ru
alias англ = trans ru:en
alias mnt = udevil mount
alias umnt = udevil umount
alias mntmobile = udevil mount ssh://u0_a217@192.168.0.32:8022/data/data/com.termux/files/home
