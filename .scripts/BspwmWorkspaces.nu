#!/usr/bin/env -S nu --no-std-lib

def "main" [] {

	bspc query -D --names
	| lines
	| skip 10
	| wrap ws
	| par-each { |it|
		upsert content (
			try {
				bspc query -d $it.ws -T
				| from json
				| xdotool getwindowname $in.focusedNodeId
				| str trim
				# | bspc query -n $in -T
				# 	| from json
				# 	| get client.instanceName
			} catch { "" }
		)
	}
	| format '{ws} : {content}'
	| to text
	# | rofi -dmenu -i -auto-select
	# | split words
	# | first
}
