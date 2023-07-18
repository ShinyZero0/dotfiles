#!/usr/bin/env nu
def "main" [] {

	bspc subscribe report -c 1
	| str trim
	| split row (char esep)
	| match $in.12 {
		"TF" => {bspc node -f newest.local.!floating}
		_ => {bspc node -f newest.local.floating}
	}
}
