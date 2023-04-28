#!/usr/bin/env nu

let choice = (

	gum confirm "Zellij layout available. Start it?" 
	| complete | get exit_code
)
if $choice == 0 {

	if ( $env.ZELLIJ? | is-empty ) {

		zellij -l ./zellij.kdl
	} else {
		zellij ac new-tab -l ./zellij.kdl
	}
} 
