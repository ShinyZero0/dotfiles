def "nu-complete gh-status" [] {[
	[value description];

	[failure "The CI does not pass."]
	[pending "The CI is currently running."]
	[success "All the CI jobs have passed."]
]}

def "nu-complete gh-review" [] {[
	[value description];

	[none "No review at all."]
	[changes-requested "There are changes to be applied."]
	[approved "The PR has been approved."]
]}

export def "pr explore" [
	owner: string
	repo: string
	--ready: bool
	--status: string@"nu-complete gh-status"
	--review: string@"nu-complete gh-review"
] {
	let query = [
		[is pr]
		[is open]
		[draft (not $ready)]
		[status $status]
		[review $review]
	]

	let url = ({
		scheme: https,
		host: github.com,
		path: $"/($owner)/($repo)/pulls",
		params: {
			q: (
				$query
				| where {|it| $it.1 != null}
				| each { || str join "%3A"  }
				| str join "+"
			)
		}
	} | url join)

	xdg-open $url
}
