def "zellij-sessions" [] {
	zellij list-sessions | lines | each { split row " " | get 0 }
}
export extern zellij [
	--config(-c): any
	--config-dir: any
	--layout(-l): any
	--help(-h)
	...args: any
]
export extern "zellij attach" [
	session: string@"zellij-sessions"
]
export extern "zellij setup" [
	--check
	...args: any
]
export alias "zellij a" = zellij attach
