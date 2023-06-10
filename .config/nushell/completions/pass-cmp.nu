def "_passList" [] {

	fd -t f . ~/.password-store/
		| lines
		| path relative-to ~/.password-store/
		| path parse
		| reject extension
		| path join
}
export extern "pass show" [

	...args: any@_passList
]
