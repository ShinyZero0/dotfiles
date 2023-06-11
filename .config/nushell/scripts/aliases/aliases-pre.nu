# old alias for competion
# TODO: turn into module
use utils.nu [ "_clip o" "_clip i" ]
alias dn = dotnet

alias vi = nvim
alias visu = nvim +SudaRead

alias q = exit
alias r = exec nu
alias fi = find
alias fii = find -i
alias g = get

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

export alias hm = home-manager
# HER MAJESTY'S SHIP
export alias hms = home-manager switch
