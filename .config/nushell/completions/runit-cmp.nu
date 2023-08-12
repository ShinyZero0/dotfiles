def _activeUserServices [] {

	[
		( ls ~/.local/share/service-graphic )
		( ls ~/.local/share/service )
	]
	| flatten
	| get name
}
def _activeRootServices [] {
	ls /var/service/ | get name
}

export extern sv [
	...args: any
]

export extern "sv status" [
	...args: string@_activeUserServices
]

export extern "sudo sv status" [
	...args: string@_activeRootServices
]
export extern "sv up" [
	...args: string@_activeUserServices
]
export extern "sv restart" [
	...args: string@_activeUserServices
]
export extern "sv down" [
	...args: string@_activeUserServices
]
