# Stealed from
#*
#*                  _    __ _ _
#*   __ _ ___  __ _| |_ / _(_) |___ ___  WEBSITE: https://goatfiles.github.io
#*  / _` / _ \/ _` |  _|  _| | / -_|_-<  REPOS:   https://github.com/goatfiles
#*  \__, \___/\__,_|\__|_| |_|_\___/__/  LICENCE: https://github.com/goatfiles/dotfiles/blob/main/LICENSE
#*  |___/
#*          MAINTAINERS:
#*              AMTOINE: https://github.com/amtoine antoine#1306 7C5EE50BA27B86B7F9D5A7BA37AAE9B486CFF1AB
#*              ATXR:    https://github.com/atxr    atxr#6214    3B25AF716B608D41AB86C3D20E55E4B1DE5B2C8B
#*

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
			null
		} else {
			[ $repo.owner $repo.repo ]
			| str join "---"
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
					$env.GH_USER? | default "" | str downcase
				)
			) {
				$in | get ssh_url
			} else {
				$in | get clone_url
			}
		),
		$outputArg
	]
}
# export def "release" [
# 	repository: string
# 	version: string
# 	--branch(-b): string
# 	--body(-B): string
# 	--draft(-d)
# ] {
# 	let repo = ($repository | _parseRepoName )
# 	{
# 		tag_name: $version
# 		target_commitish: (
#
# 			$branch 
# 			| default (
# 				git branch --show-current | str trim
# 			)
# 		)
# 		name: $version
# 		body: (
# 			$body | default $"Release of version ($version)"
# 		)
# 		draft: true
# 		prerelease: false
# 	}
# 	| _postToApi $"repos/($repo.owner)/($repo.repo)/releases"
# }
def _runCommandFromList [ parts: list<string> ] {
	
	nu -c (
		$parts
		| where { || $in != null }
		| str join " "
	)
}

def _getAuthHeader [] {

	[
		Authorization $"Bearer (
			$env.GH_TOKEN?
			| default (
				open ~/.config/gh/hosts.yml | get "github.com".oauth_token
			)
		)"
	]
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
		return {

			owner: $env.GH_USER
			repo: $repo
		}
	} else if ( $length == 2 ) {
		return {

			owner: $split.0
			repo: $split.1
		}
	}
}

# export def "pr explore" [
# 	owner: string
# 	repo: string
# 	--ready: bool
# 	--status: string@"nu-complete gh-status"
# 	--review: string@"nu-complete gh-review"
# ] {
# 	let query = [
# 		[is pr]
# 		[is open]
# 		[draft (not $ready)]
# 		[status $status]
# 		[review $review]
# 	]
#
# 	let url = ({
# 		scheme: https,
# 		host: github.com,
# 		path: $"/($owner)/($repo)/pulls",
# 		params: {
# 			q: (
# 				$query
# 				| where {|it| $it.1 != null}
# 				| each { || str join "%3A"  }
# 				| str join "+"
# 			)
# 		}
# 	} | url join)
#
# 	xdg-open $url
# }
# TODO: documentation
# def unpack-pages [] {
#     sd -s "}][{" "},{"
# }
#
#
# # TODO: documentation
# def pull [
#   endpoint: string
# ] {
#     gh api --paginate $endpoint  # get all the raw data
#         | unpack-pages           # split the pages into a single one
#         | from json              # convert to JSON internally
# }
#
#
# # TODO: documentation
# export def "me notifications" [] {
#     pull /notifications
# }
#
#
# # TODO: documentation
# export def "me issues" [] {
#     pull /issues
# }
#
#
# # TODO: documentation
# export def "me starred" [
#     --reduce (-r): bool
# ] {
#     if ($reduce) {
#         pull /user/starred
#         | select -i id name description owner.login clone_url fork license.name created_at pushed_at homepage archived topics size stargazers_count language
#     } else {
#         pull /user/starred
#     }
# }
#
#
# # TODO: documentation
# export def "me repos" [
# 	owner: string
# 	--user (-u): bool
# ] {
# 	let root = if ($user) { "users" } else { "orgs" }
# 	pull $"/($root)/($owner)/repos"
# }
#
#
# # TODO: documentation
# export def "me protection" [
# 	owner: string
# 	repo: string
# 	branch: string
# ] {
# 	pull (["" "repos" $owner $repo "branches" $branch "protection"] | str join "/")
# }
#
#
