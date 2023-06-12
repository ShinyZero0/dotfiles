def-env _select [
	dir?: string
] {
	let obj = ( _getFocusChoice $dir )
	_confirmOpener -nN $obj
}
def-env _open [
	dir?: string
] {
	let obj = ( _getFocusChoice $dir )
	_confirmOpener -n $obj
}
def-env _focus [
	dir?: string
] {
	let obj = ( _getFocusChoice $dir )
	_confirmOpener $obj
}

def _getFocusChoice [
	dir?: string # search relative to first argument if present
] {
	mut obj = ""
	if ($dir | is-empty) {

		$obj = ( fd --no-ignore-vcs -Hd 4 .
		| ^$env.FUZZY_FINDER )
	} else {

		$obj = ( fd --no-ignore-vcs -Hd 4 . ( $dir | path expand )
		| ^$env.FUZZY_FINDER )
	}
	return $obj
}

def-env _confirmOpener [
	path: string
	--nocd(-n)
	--rlynocd(-N)
] {
	if $path == "" { return }
	if ($path | path expand | path type) == dir {

		if $rlynocd {
			_select ( $path | path expand )
			return
		} else {
			cd $path
			return
		}
	} else if not $nocd {

		cd ( $path | path dirname )
	}

	mut file = ""
	if $nocd {
		$file = ($path | path expand -n) # don't resolve symlinks
	} else {
		$file = ($path | path basename)
	}
	let hand = ( opener -q $file ) # get the program name
	let exit = ( gum confirm $'Open with default handler: "($hand)"?' | complete | get exit_code )
	if $exit == 0 {
		# my custom opener
		opener $file
	} else {
		# paste the path into clipboard. full path if not focused and basename if focused, see line 41
		$file | _clip i
	}
}

export alias f = _focus # cd to file's basedir and open
export alias o = _open # don't cd and just open
export alias s = _select # don't cd and just open
