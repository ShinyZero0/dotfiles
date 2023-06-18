#!/usr/bin/env nu

use ~/.config/nushell/scripts/utils.nu ansi-temp

def main [ --update(-u): bool ] {

	tabs 4
	let Entries = (open ~/.config/nushell/files.nuon)
	for entry in $Entries {

		let okMessage = (

			if $update {
				echo $"(ansi-temp "UPDATING:\n" magenta)\t($entry.file) exists"
			} else {
				echo $"(ansi-temp "OK:\n" green)\t($entry.file) exists"
			}
		)
		if ($entry.file | path exists) {

			print $okMessage
			if $update {
				http get $entry.remote | save -f ( $entry.file | path expand )
			}
		} else {
			ensure $entry.file 
			print $"(ansi-temp "FIXING:\n" yellow)\t($entry.file) not exists"
			http get $entry.remote | save ( $entry.file | path expand )
		}
	}
}
def "ensure" [file] {
	mkdir ($file | path expand | path dirname)
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
			print $"(ansi-temp "FAIL:" red)\t($entry) doesn't exist"
		} else {
			print $"(ansi-temp "OK:" green)\t($entry) exists"
		}
	}
}
