alias t = _focus # cd to file's basedir and open
alias o = _open # don't cd and just open
alias s = _select # don't cd and just open

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
		$obj = ( fd --no-ignore-vcs -Hd 5 . | zf )
	} else {
		$obj = ( fd --no-ignore-vcs -Hd 5 . ( $dir | path expand ) | zf )
	}
	return $obj
}

def-env _confirmOpener [
	path: string
	--nocd(-n)
	--rlynocd(-N)
] {
	if ($path | path expand | path type) == dir and ( not $rlynocd ) {
		cd $path
		return
	} else if not $nocd {
		cd ( $path | path dirname )
	}
	mut file = ""
	if $nocd {
		$file = ($path | path expand)
	} else {
		$file = ($path | path basename)
	}
	let hand = ( opener -q $file ) # get the program name
	let exit = ( gum confirm $'Open with default handler: "($hand)"?' | complete | get exit_code )
	if $exit == 0 {
		opener $file # my custom opener
	} else {
		# paste the path into prompt. full path if not focused and basename if focused, see line 41
		# sadly can't move the cursor to line start so at least add space
		commandline $" `($file)`" 
	}
}
