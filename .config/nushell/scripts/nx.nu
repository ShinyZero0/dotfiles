use utils [
	_home
]

export def nx-init [ name?: string ] {

	cp ~/.stuff/nix/dotnet/flake.lock ./
	cp ~/.stuff/plates/.envrc ./
	direnv allow

	let name = ( $name | default ( $env.PWD | path basename ) )

	open ~/.stuff/nix/dotnet/flake.nix 
		| str replace -as "<name>" $name
		| str replace -as "<version>" "0.0.1"
		| save flake.nix
}

export def nx-sync [ dir?: any ] {
	let LockFile = ( "~/.stuff/nix/dotnet/flake.lock" | path expand ) 

	let directory = ( $dir | default ( _home dev ) )
	open $LockFile
		| from json
		| upsert nodes.nixpkgs (
			open ~/.config/home-manager/flake.lock
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

	nix flake update ~/.config/home-manager/
	nx-sync
}
