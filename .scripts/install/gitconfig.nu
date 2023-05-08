#!/usr/bin/env nu

def main [] {

	let name = (
		$env.usrname? | default ( input "Git username:\n" )
	)
	let email = (
		$env.email? | default ( input "Git email:\n" )
	)
	let gitconfig = $'[user]
	name = ($name)
	email = ($email)
[core]
	pager = delta
	excludesFile = ~/.gitignore-global

[interactive]
	diffFilter = delta --color-only --features=interactive

[delta]
	features = decorations

[delta "interactive"]
	keep-plus-minus-markers = false

[delta "decorations"]
	commit-decoration-style = blue ol
	commit-style = raw
	file-style = omit
	hunk-header-decoration-style = blue box
	hunk-header-file-style = red
	hunk-header-line-number-style = "#067a00"
	hunk-header-style = file line-number syntax

[pull]
	rebase = false

[diff "pandoc"]
	textconv=pandoc --to=markdown
	prompt = false

[diff "json"]
	textconv = nujson
	prompt = false

[alias]
	wdiff = diff --word-diff=color --unified=1`
	'
	$gitconfig | save -f ~/.gitconfig
}
