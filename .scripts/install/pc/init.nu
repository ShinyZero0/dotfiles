#!/usr/bin/env nu

use ~/.config/nushell/scripts/utils.nu _currentfile

export def _this [ file: string ] {
	_currentfile | path dirname | path join ( $file | str replace '^./' '' )
}
export def _thisdo [ file: string ] {
	nu ( _this $file )
}

_thisdo ./packages.nu
_thisdo ./root.nu
