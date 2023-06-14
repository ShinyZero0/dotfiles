# old alias for competion
# TODO: turn into module
use utils.nu [ "Clip o" "Clip i" ]
alias dn = dotnet

alias vi = nvim
alias visu = nvim +SudaRead

alias q = exit
alias r = exec nu

export alias ll = ls --long
export alias la = ls --all

alias fi = find
alias fii = find -i
alias g = get

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
