def "pkill" [] {
	ps | get name
}
export extern pkill [

	...args: string@"pkill"
]
