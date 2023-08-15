mkcd()
{
    mkdir -p "$1"
    cd "$1"
}
ungit-cb()
{
	xsel -ob \
		| awk -F "[/#]" '{print $4 "/" $5}' \
		| yank
}
camerasmooth()
{
	sed -i 's/cameraSmooth.*/cameraSmooth:r=-1/' $HOME/.config/WarThunder/Controls/TankRB.blk
}
yankpath()
{
	realpath $1 | yank
}
share()
{
	link=$(curl -F file="@$1" "https://0x0.st")
	print $link | yank
	print "$link copied to clipboard!"
}
fzcd()
{
	cd "$(bfs -maxdepth 4 -type d $1 -print0 | fzf --read0 || print .)"
}
zsanity()
{
	zmv -v '(**/)(* *)' '$1${2//[,* #]/_}'
}
