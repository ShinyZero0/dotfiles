# old alias for competion
# TODO: turn into module
use utils.nu [ "Clip o" "Clip i" ]
export alias visu = nvim +SudaRead
export alias dn = dotnet

export alias vi = nvim

export alias q = exit
export alias r = exec nu
export alias nue = yadm enter exec nvim ~/.config/nushell/

export alias ll = ls --long
export alias la = ls --all

export alias fi = find
export alias fii = find -i
# export alias g = get

export alias dwn = ls ~/Downloads/
export alias pic = ls ~/Pictures/
export alias recent = sort-by modified
export def latest [] {
	$in | recent | last
}
export alias xtr = atool -x
export alias ar = atool -a

export alias mnt = udevil mount
export alias umnt = udevil umount

export alias hm = home-manager
# HER MAJESTY'S SHIP
export alias hms = home-manager switch
export alias hme = yadm enter exec home-manager edit
export alias ru = trans :ru
export alias англ = trans :en
