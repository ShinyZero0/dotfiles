def "nu-cmp pkill" [] {
	ps | get name
}
export extern pkill [

	...args: string@"nu-cmp pkill"
]
