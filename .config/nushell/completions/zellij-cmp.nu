def "zellij-sessions" [] {
	zellij list-sessions | lines | each {||split row " " | get 0 } 
}
export extern zellij [
	--config(-c): any
	--config-dir: any
	--layout(-l): any
	...args: any
]
export extern "zellij attach" [
	session: string@"zellij-sessions"
]
alias "zellij a" = zellij attach
