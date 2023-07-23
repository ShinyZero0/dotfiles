#!/usr/bin/env nu
def "main" [] {

	bspc subscribe report -c 1
	| str trim
	| split row (char esep)
	| where { str starts-with 'T' }
	| first
	| match $in {
		"TF" => {bspc node -f newest.local.!floating}
		_ => {bspc node -f next.local.floating}
	}
}
