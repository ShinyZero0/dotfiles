use utils [
	_home
]

export def nx-init [
	lang: any
	--name(-n): any
	--version(-v): any
] {

	cp ~/.stuff/nix/flake.lock ./
	cp ~/.stuff/plates/.envrc ./
	direnv allow

	let name = ( $name | default ( $env.PWD | path basename ) )
	let version = ( $version | default "0.0.1" )

	open $"~/.stuff/nix/($lang)/flake.nix" 
		| str replace -as "<name>" $name
		| str replace -as "<version>" $version
		| save flake.nix
}

export def nx-sync [ dir?: any ] {

	let LockFile = ( "~/.stuff/nix/flake.lock" | path expand ) 

	let directory = ( $dir | default ( _home dev ) )
	open $LockFile
		| from json
		| upsert nodes.nixpkgs (
			open ~/.stuff/nix/flake.lock
			| from json
		).nodes.nixpkgs
		| to json
		| save -f $LockFile

	let list = ( fd flake.lock $directory | lines )
	for entry in $list {
		cd ( $entry | path dirname )
		open flake.lock 
			| from json 
			| update nodes.nixpkgs (
				open $LockFile
				| from json
			).nodes.nixpkgs
			| to json
			| save -f flake.lock
	}
}

export def nx-update [ ...args ] {

	nix flake update ~/.stuff/nix/
	nx-sync
}
