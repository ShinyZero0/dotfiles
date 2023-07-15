use utils.nu *
use pipes.nu [un-ext get-ext is-child-of]

export def mvnrp [

	old: string
	new: string
] {
	$env.NvimConfig = ( "~/.config/nvim" | path expand )

	mv $old $new
	$env.oldFull = ( $old | path expand )
	$env.newFull = ( $new | path expand )
	if ( $new | get-ext ) == "lua" and (
		$new | is-child-of $env.NvimConfig
	) {
		let files = ( fd -t f -e lua -e vim . $env.NvimConfig | lines)
		for file in $files {
			_replaceLuaRequires $file
		}
	}

	let files = ( fd -t f | lines  )
	for file in $files {

		if ( file --mime $file | str contains "charset=binary" ) {
			continue
		}
		let ext = ( $file | get-ext )
		if $ext == "nu" and (

			$env.NU_LIB_DIRS | any {
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
			| _sameReplace { path relative-to $env.PWD } $old $new
			| _sameReplace { str replace $env.HOME '$HOME' } $old $new
			| _sameReplace { str replace $env.HOME '~' } $old $new
			| save -f $file

	}
}

def _replaceLuaRequires [
	file: string
] {

	let ft = ( $env.newFull | path type )
	let oldModule = (

		$env.oldFull
			| path relative-to $env.NvimConfig
			| un-ext
			| path split
			| str join "."
	)
	let newModule = (

		$env.newFull
			| path relative-to $env.NvimConfig
			| un-ext
			| path split
			| str join "."
	)
	if $ft == "file" {
		open --raw $file | str replace -as $"require\(\"($oldModule)\"\)" $"require\(\"($newModule)\"\)" | save -f $file
	} else if $ft == "dir" {
		fnrfiles ( 'require\("' + $oldModule + '(.*)"\)' ) ( 'require("' + $newModule + '$1")' ) $file

	}
}

def _sameReplace [
	func: closure old: string new: string
] {
	$in | str replace -a ($old | do $func) ($new | do $func)
}
