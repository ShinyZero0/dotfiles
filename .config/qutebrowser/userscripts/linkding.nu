#!/usr/bin/env nu
def "main" [] { }
# open one bookmark
def "main get" [] {

	let bmarks = (
		http get http://localhost:9090/api/bookmarks/ -H [ Authorization $"Token ($env.LINKDING_TOKEN)" ]
		| get results
	)
	let url = (
		$bmarks | get (
			$bmarks
			| format '{url} - {website_title}'
			| to text
			| rofi -dmenu -format i
			| into int
		)
		| get url
	)
	$"open -t ($url)" | save -f $env.QUTE_FIFO
}
# add current website to bookmarks
def "main post" [] {
	
	http post --content-type application/json -H [Authorization $"Token ($env.LINKDING_TOKEN)"] http://localhost:9090/api/bookmarks/ { url: $env.QUTE_URL }
}
