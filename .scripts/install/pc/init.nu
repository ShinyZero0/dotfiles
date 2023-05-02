#!/usr/bin/env nu

use ~/.config/nushell/scripts/utils.nu _currentfile

export def _pc [ file: string ] {
	_currentfile | path dirname | path join ( $file | path basename )
}
export def _pcdo [ file: string ] {
	nu ( _pc $file )
}

_pcdo ./packages.nu
_pcdo ./root.nu
