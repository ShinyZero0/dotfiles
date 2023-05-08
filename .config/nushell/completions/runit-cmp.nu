export extern sv [

	...args: any
]

export extern "sv status" [

	...args: string@_activeUserServices
]

export extern "sudo sv status" [

	...args: string@_activeRootServices
]

def _activeUserServices [] {
	ls $env.SVDIR | get name
}
def _activeRootServices [] {
	ls /var/service/ | get name
}
