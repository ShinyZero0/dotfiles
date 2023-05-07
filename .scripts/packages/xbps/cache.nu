#!/usr/bin/env nu

^xbps-query -Rs "*" 
	| lines 
	| each { |line|
		$line |  parse -r '\[-\]\s+(?P<value>\S+)-\S+\s+(?P<description>.+)' | into record
	} 
	| to json | save -f ~/.cache/xbps-cache.json
