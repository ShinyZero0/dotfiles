mkcd()
{
    mkdir -p "$1"
    cd "$1"
}
ungit-cb()
{
	xsel -ob \
	| awk -F "[/#]" '{print $4 "/" $5}' \
	| xsel -ib --trim
}
