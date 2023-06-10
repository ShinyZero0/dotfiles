export def "sec check" [

	--file(-f): any
	--strict: bool = false
] {

	let data = if ( $file | is-empty ) {
		$in
	} else {
		open $file
	}
	$data
	| nu -c (
		[ "rg --pretty -e" (_getPatternsArgs) ]
		| str join " "
	)
}

export def "sec trust" [] {


}

def "_getPatternsArgs" [] {

	[
		"curl",
		"wget",
		"gnupg",
		"ssh",
		"find",
		"fd"
	]
	| str join " -e "

}
