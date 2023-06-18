export module funcs {
	use utils.nu [ "Clip o" "Clip i"]
	# open file or dir
	export def-env _select [
		dir?: string 
	] {
		let-env FOCUS = false
		let-env NOCD = true
		_confirmOpener $dir
	}
	
	# open file without cd or cd if choosed dir
	export def-env _open [
		dir?: string 
	] {
		let-env FOCUS = false
		let-env NOCD = false
		_confirmOpener $dir
	}

	# cd and open a file or cd if choosed dir
	export def-env _focus [
		dir?: string
	] {
		let-env FOCUS = true
		let-env NOCD = false
		_confirmOpener $dir
	}
	def _shortenPaths [] {
		lines 
		| str replace $env.HOME '~' 
		| to text
		| str trim
	}
	def _getFocusChoice [
		dir?: string # search relative to first argument if present
	] {
		if ($dir | is-empty) {
			( fd --no-ignore-vcs -Hd 4 . | zf )
		} else {
			( fd --no-ignore-vcs -Hd 4 . ( $dir | path expand ) | _shortenPaths | zf )
		}
	}

	def-env _confirmOpener [ dir ] {

		let-env OBJ = (_getFocusChoice $dir)	
		if $env.OBJ == "" { return }
		let path = (
			$env.OBJ | path expand
		)
		if ($path | path type) == dir {

			if $env.NOCD {
				# _select ( $path | _shortenPaths )
				# return
			} else {
				z $path
				return
			}
		} else if $env.FOCUS {

			z ( $path | path dirname )
		}

		let file = (
			$path | path relative-to $env.PWD
		)
		# if not $env.FOCUS {
		# 	$path | path expand -n # don't resolve symlinks
		# } else {
		# 	$path | path basename
		# }
		let hand = ( opener -q $file ) # get the program name
		let exit = ( gum confirm $'Open with default handler: "($hand)"?' | complete | get exit_code )
		if $exit == 0 {
			# my custom opener
			opener $file
		} else {
			# paste the path into clipboard. full path if not focused and basename if focused, see line 41
			$file | Clip i
		}
	}
}

export module aliases {

	use funcs *
	export alias f = _focus
	export alias o = _open
	export alias s = _select
}
