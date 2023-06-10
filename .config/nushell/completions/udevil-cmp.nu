def _unmountedDisks [] {

	lsblk -fyJ -o PATH,MOUNTPOINT,TYPE
	| from json
	| get blockdevices
	| where type == part
	| where mountpoint == $nothing
	| get path
}
def _mountedDisks [] {

	ls /media | get name
}
export extern "udevil mount" [
	...args: string@_unmountedDisks
]
export extern "udevil umount" [
	...args: string@_mountedDisks
]
