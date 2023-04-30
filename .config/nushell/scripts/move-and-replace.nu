export def mvnrp [

	old: string 
	new: string
] {
	let-env NvimConfig = ( "~/.config/nvim" | path expand )

	mv $old $new
	let-env oldFull = ( $old | path expand )
	let-env newFull = ( $new | path expand )
	if ( $new | getext ) == "lua" and (
		$new | is-child-of $env.NvimConfig
	) {
		let files = ( fd -t f . $env.NvimConfig | lines)
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
					$old | is-child-of $in
				) and (
					$new | is-child-of $in
				)
			}
		) {
			sd $"\(source|use) ($old | path basename)" $'$1 ($new | path basename)' $file
		}

		open --raw $file
			| str replace $env.oldFull $env.newFull 
			| _sameReplace { || relpath $env.PWD } $old $new 
			| _sameReplace { || str replace $env.HOME '$HOME' } $old $new 
			| _sameReplace { || str replace $env.HOME '~' } $old $new
			| save -f $file

	}
}

def _replaceLuaRequires [
	file: string
] {

	let ft = ( $env.newFull | path type )
	let oldModule = (

		$env.oldFull
			| relpath $env.NvimConfig
			| path parse
			| reject extension
			| transpose k v | get v
			| str join "."
	)
	let newModule = (

		$env.newFull
			| relpath $env.NvimConfig
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

def _sameReplace [
	func: closure old: string new: string
] {
	$in | str replace -a ($old | do $func) ($new | do $func)
}
