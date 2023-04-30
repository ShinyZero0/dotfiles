# def with [func: closure] {
#
# 	let input = $in
# 	$input | $func 
# 	$input
# }

export def mvnrp [
	old: string new: string
] {

	let-env NvimLua = ( "~/.config/nvim/lua/" | path expand )

	mv $old $new
	let-env oldFull = ( $old | path expand )
	let-env newFull = ( $new | path expand )
	if ( $new | getext ) == "lua" and (
		$new | ischildof $env.NvimLua
	) {
		let files = ( fd -t f . $env.NvimLua | lines)
		for file in $files {
			_replaceLuaRequires $file
		}
	}

	let files = ( fd -t f | lines  )
	for file in $files {
		let ext = ( $file | getext )
		if $ext == "nu" and (

			$env.NU_LIB_DIRS | any { ||
				(
					$old | ischildof $in
				) and (
					$new | ischildof $in
				)
			}
		) {
			sd $"\(source|use) ($old | path basename)" $'$1 ($new | path basename)' $file
		}

		open $file
		| str replace $env.oldFull $env.newFull 
		| str replace (
			sameAction { || relpath $env.PWD } $old $new 
		)
		| str replace (
			sameAction { || str replace $env.HOME '$HOME' } $old $new 
		)
		| str replace (
			sameAction { || str replace $env.HOME '~' } $old $new
		)

	}
}

def _replaceLuaRequires [
	file: string
] {

	let ft = ( $env.newFull | path type )
	let oldModule = (

		$env.oldFull
		| path relative-to $env.NvimLua
		| path parse
		| reject extension
		| transpose k v | get v
		| str join "."
	)
	let newModule = (

		$env.newFull
		| path relative-to $env.NvimLua
		| path parse
		| reject extension
		| transpose k v | get v
		| str join "."
	)
	if $ft == "file" {
		open $file | str replace -as $"require\(\"($oldModule)\"\)" $"require\(\"($newModule)\"\)" | save -f $file
	} else if $ft == "dir" {
		fnrfiles ( 'require\("' + $oldModule + '(.*)"\)' ) ( 'require("' + $newModule + '$1")' ) $file

	}
}
export def getext [] {
	$in | path parse | get extension
}
export def relpath [ parent: string ] {
	$in | path expand | path relative-to ( $parent | path expand )
}
export def ischildof [ parent: string ] {
	$in | path expand | str starts-with ( $parent | path expand )
}

export def parse-help [] {

    $in 
	| parse -r '\s\s+(?:-(?P<short>\w)[,\s]+)?(?:--(?P<long>[\w-]+))\s*(?:<(?P<format>.*)>)?\s*(?P<description>.*)?'
}

export def fnrfiles [
	find: string replace: string ...files: string
] {
	for file in $files {
		open $file | str replace -a $find $replace | save -f $file
	}
}
def sameAction [
	func: closure
	...args: any
] {
	mut list = []
	for entry in $args {
		$list = ( $list | append ( $entry | do $func ) )
	}
	$list | to text
}
