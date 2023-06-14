
use utils.nu ansi-temp
def "_at" [] {

	let colors = (_getColors)
	( ansi-temp "@" { fg: $colors.cyanDark attr: b } )
}
def _getColors [] {

	return {

		black: '#100e23'
	    grayDark: '#565575'
		gray: '#a6b3cc'
		grayLight: '#cbe3e7'
		white: '#FAFAFA'
	
		redDark: '#ff5458'
		red: '#ff8080'
	
		greenDark: '#62d196'
		green: '#95ffa4'
	
		yellowDark: '#ffb378'
		yellow: '#ffe9aa'
	
		blueDark: '#65b2ff'
		blue: '#91ddff'
	
		purpleDark: '#906cff'
		purple: '#ff99e3'
	
		cyanDark: '#63f2f1'
		cyan: '#aaffe4'
	
	}
}

export def create_left_prompt [] {

	let colors = (_getColors)
    mut home = ""
    try {

	if $nu.os-info.name == "windows" {
	    $home = $env.USERPROFILE
	} else {
	    $home = $env.HOME
	}
    }

		let termuxPrefix = (
			try {

				$env.PREFIX
					| path split
					| drop 1
					| path join
			} catch {
				"4efbf0c9-8eaa-4d0f-a60e-fb95441f7481"
			}
		)
    let dir = (

	$env.PWD
			| str replace $home '~'
			| str replace $termuxPrefix '/'
    )

    let pathSegment = ( ansi-temp $dir { fg: $colors.green attr: b } )
    let yadmSegment = if $env.IS_YADM {
		[
			(_at)
			( ansi-temp "Y" { fg: $colors.redDark attr: b } )
		]
		| str join
    }
    let nixSegment = if (

		$env.PATH
		| any {
			str contains "/nix/store"
		}
    ) {
		[
			(_at)
			( ansi-temp "N" { fg: $colors.blue attr: b } )
		]
		| str join
    }
	let sshSegment = if (
		$env.SSH_CLIENT? | is-empty
	) {
		null
	} else {
		[
			(_at)
			(ansi-temp 'S(' { fg: $colors.purple attr: b })
			(ansi-temp ( uname -n ) { fg: $colors.blueDark attr: b } )
			(ansi-temp ')' { fg: $colors.purple attr: b })
		]
		| str join
	}

    let left_prompt = (
	[
	    $pathSegment,
	    $yadmSegment
	    $nixSegment,
		$sshSegment,
	]
	| str join
    )

    $left_prompt
}

export def create_right_prompt [] {

	let colors = (_getColors)
    let timeSegment = (
	[ (
			ansi-temp (date now | date format '%r') { fg: $colors.purple attr: b }
		) ]
	| str join
    )
    let last_exit_code = if ( $env.LAST_EXIT_CODE != 0 ) {
		[
	    ( ansi-temp $env.LAST_EXIT_CODE $colors.redDark )
	]
	| str join
	} else { "" }

    let right_prompt = (
	[
	    $last_exit_code, (char space), $timeSegment
	]
	| str join
    )

    $right_prompt
}

export def GetDarkTheme [] {

	let colors = (_getColors)
	return {
		# color for nushell primitives
		separator: $colors.white
		leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
		header: $colors.green
		empty: $colors.blue
		# Closures can be used to choose colors for specific values.
		# The value (in this case, a bool) is piped into the closure.
		bool: { if $in { $colors.cyan } else { $colors.redDark } }
		int: $colors.yellowDark
		filesize: { |e|

			if $e == 0b {
				$colors.white
			} else if $e < 1mb {
				$colors.cyan
			} else if $e < 100mb {
				$colors.yellow
			} else if $e < 500mb {
				$colors.yellowDark
			} else if $e < 2gb {
				$colors.red
			} else {
				$colors.redDark
			}
		}
		duration: $colors.white
		date: { (date now) - $in |
			if $in < 1hr {
				$colors.redDark
			} else if $in < 6hr {
				$colors.red
			} else if $in < 1day {
				$colors.yellowDark
			} else if $in < 3day {
				$colors.yellow
			} else if $in < 1wk {
				$colors.green
			} else if $in < 6wk {
				$colors.greenDark
			} else if $in < 52wk {
				$colors.cyan
			} else { $colors.cyanDark }
		}
		range: $colors.yellowDark
		float: $colors.yellowDark
		string: $colors.yellow
		nothing: $colors.grayDark
		binary: $colors.yellowDark
		cellpath: white
		row_index: green_bold
		record: white
		list: white
		block: white
		hints: dark_gray

		shape_and: $colors.red
		shape_binary: purple_bold
		shape_block: $colors.cyanDark
		shape_bool: $colors.cyanDark
		shape_custom: $colors.cyan
		shape_datetime: $colors.cyanDark
		shape_directory: $colors.cyan
		shape_external: $colors.cyan
		shape_externalarg: $colors.cyanDark
		shape_filepath: $colors.cyan
		shape_flag: blue_bold
		shape_float: $colors.yellowDark
		# shapes are used to change the cli syntax highlighting
		shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: b }
		shape_globpattern: cyan_bold
		shape_int: $colors.yellowDark
		shape_internalcall: cyan_bold
		shape_list: cyan_bold
		shape_literal: blue
		shape_match_pattern: green
		shape_matching_brackets: { attr: u }
		shape_nothing: light_cyan
		shape_operator: $colors.red
		shape_or: $colors.red
		shape_pipe: $colors.purple
		shape_range: $colors.yellowDark
		shape_record: $colors.cyanDark
		shape_redirection: $colors.purple
		shape_signature: $colors.purpleDark
		shape_string: $colors.yellow
		shape_string_interpolation: cyan_bold
		shape_table: blue_bold
		shape_variable: $colors.purple
		shape_vardecl: $colors.purple
	}
}
