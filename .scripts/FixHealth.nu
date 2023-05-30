#!/usr/bin/env nu

use utils.nu _ansiTmp

def main [ --update(-u): bool ] {

	tabs 4
	let Entries = (open ~/.config/nushell/files.nuon)
	for entry in $Entries {

		let okMessage = (

			if $update {
				echo $"(_ansiTmp "UPDATING:\n" magenta)\t($entry.file) exists"
			} else {
				echo $"(_ansiTmp "OK:\n" green)\t($entry.file) exists"
			}
		)
		if ($entry.file | path exists) {

			print $okMessage
			if $update {
				http get $entry.remote | save -f ( $entry.file | path expand )
			}
		} else {

			print $"(_ansiTmp "FIXING:\n" yellow)\t($entry.file) not exists"
			http get $entry.remote | save ( $entry.file | path expand )
		}
	}
}

def "main bins" [] {

	tabs 4
	let Entries = [
		"rg"
		"fd"
		"tput"
		"zf"
		"nq"
		"sv"
		"git"
		"qrencode"
		"vipe"
		"xclip"
		"xsel"
		"file"
	]
	for entry in $Entries {

		if (which $"^($entry)" | is-empty) {
			print $"(_ansiTmp "FAIL:" red)\t($entry) doesn't exist"
		} else {
			print $"(_ansiTmp "OK:" green)\t($entry) exists"
		}
	}
}
