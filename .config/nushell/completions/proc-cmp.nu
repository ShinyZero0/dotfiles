def "ps-cmp" [] {
	ps | get name | path basename | uniq
}
export extern pkill [
	...args: string@ps-cmp
]
