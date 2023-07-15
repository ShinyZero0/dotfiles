use utils [
	Home
]

def "lang-cmp" [] {
	
	ls ~/.stuff/nix/
	| where type == dir
	| get name
	| path basename
}

export def nx-init [
	lang: string@lang-cmp
	--name(-n): any
	--version(-v): any
] {

	cp ~/.stuff/nix/flake.lock ./
	cp ~/.stuff/plates/.envrc ./

	try { git rev-parse HEAD } catch {

		git init
		git add .
		git commit -m "init"
	}

	let name = ( $name | default ( $env.PWD | path basename ) )
	let version = ( $version | default "0.0.1" )
	# let revision = ( git rev-parse HEAD | str trim )
	let username = $env.GH_USER

	open $"~/.stuff/nix/($lang)/flake.nix"
		| str replace -as "<username>" $username
		| str replace -as "<name>" $name
		| str replace -as "<version>" $version
		| save flake.nix

	ls $"~/.stuff/nix/($lang)"
		| where name != flake.nix
		| get name
		| each {cp $in ./}

	git add flake.nix
	direnv allow
}

export def nx-sync [ dir?: any = /home/zero/dev ] {

	let LockFile = ( "~/.stuff/nix/flake.lock" | path expand )

	open $LockFile
		| from json
		| upsert nodes.nixpkgs (
			open ~/.stuff/nix/flake.lock
			| from json
		).nodes.nixpkgs
		| to json
		| save -f $LockFile

	let list = ( fd flake.lock $dir | lines )
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

export def nx-update [] {

	nix flake update ~/.stuff/nix/
	nx-sync
}
export def "nx-inspect" [ dir?: any = /home/zero/dev ] {
	
	fd flake.lock $dir
	| lines
	| wrap file
	| each { |entry|
		upsert value (
			open $entry.file
				| from json
				| get nodes
				| transpose key value
				| where key =~ nixpkgs
				| get value.locked.rev
		)
	}
	| flatten
	# | wrap 
}
