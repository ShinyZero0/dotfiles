
use commands.nu *

export def "clone" [

	repository: string
	--depth(-d): int
	--full(-f) # owner---repo name for output directory
] {

	let repo = ( $repository | _parseRepoName )
	let depthArg = (
		if ($depth | is-empty) {
			null
		} else {
			$"--depth ($depth)"
		}
	)
	let outputArg = (
		if $full {

			[ $repo.owner $repo.repo ]
			| str join "---"
		} else {
			null
		}
	)
	_runCommandFromList [
		"git clone",
		$depthArg,
		(
			_getFromApi $"repos/($repo.owner)/($repo.repo)"
			| if (
				(
					$repo.owner | str downcase
				) == (
					$env.GH_USER?
						| default ""
						| str downcase
				)
			) {
				get ssh_url
			} else {
				get clone_url
			}
		),
		$outputArg
	]
}

def _runCommandFromList [ parts: list<string> ] {

	nu -c (
		$parts
		| where { $in != null }
		| str join " "
	)
}

def _getAuthHeader [] {

	let token = (

		$env.GH_TOKEN?
		| default (
			open ~/.config/gh/hosts.yml | get "github.com".oauth_token
		)
	)
	[
		Authorization
		$"Bearer ($token)"
	]
}

# get data from github api endpoint
export def "get-gh" [ endpoint: string ] {
	_getFromApi $endpoint
}

def _getFromApi [ endpoint: string ] {

	http get -H (_getAuthHeader) $"https://api.github.com/($endpoint)"
}

def _postToApi [ endpoint: string ] {

	http post -H (_getAuthHeader) $"https://api.github.com/($endpoint)" ( $in | to json )
}

def _parseRepoName [] {

	let repo = $in
	let split = ( $repo | path split )
	let length = ( $split | length )
	if ( $length == 1 ) {
		{
			owner: $env.GH_USER
			repo: $repo
		}
	} else if ( $length == 2 ) {
		{
			owner: $split.0
			repo: $split.1
		}
	}
}

