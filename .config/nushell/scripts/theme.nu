
def _getColors [] {
	{
		white: '#FAFAFA'
		black: '#100e23'
		grayDark: '#565575'
		
		red: '#ff8080'
		redDark: '#ff5458'
		
		green: '#62d196'
		greenBright: '#95ffa4'
		
		yellowDark: '#ffb378'
		yellow: '#ffe9aa'
		
		blueDark: '#65b2ff'
		blue: '#91ddff'
		
		purpleDark: '#906cff'
		purple: '#ff99e3'
		
		cyanDark: '#63f2f1'
		cyan: '#aaffe4'
		
		gray: '#a6b3cc'
		grayLight: '#cbe3e7'
	}
}

export def create_left_prompt [] {

    mut home = ""
    try {

        if $nu.os-info.name == "windows" {
            $home = $env.USERPROFILE
        } else {
            $home = $env.HOME
        }
    }

    let dir = (
        $env.PWD | str replace $home '~'
    )

    let path_segment = ( _ansiTmp $dir gb )
    let yadm_segment = if (
		$env.PROMPT? 
		| default "" 
		| str contains "yadm"
    ) {
		[
			( _ansiTmp "@" light_cyan_bold )
			( _ansiTmp "yadm" red_bold )
		]
		| str join
    } 
    let nix_segment = if (
		$env.PATH | any { ||
			str contains "/nix/store"
		}
    ) {
		_ansiTmp "  " blue
    } 

    let left_prompt = ( 
        [
            $path_segment,
            $nix_segment,
            $yadm_segment 
        ] 
        | str join
    )

    $left_prompt
}

export def create_right_prompt [] {

    let time_segment = (
        [ (
			_ansiTmp (date now | date format '%r') '#ff99e3'
		) ] 
        | str join
    )
    let last_exit_code = if ( $env.LAST_EXIT_CODE != 0 ) { 
		[
            ( _ansiTmp $env.LAST_EXIT_CODE r )
        ] 
        | str join
	} else { "" }

    let right_prompt = (
        [
            $last_exit_code, (char space), $time_segment
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
		header: $colors.greenBright
		empty: $colors.blue
		# Closures can be used to choose colors for specific values.
		# The value (in this case, a bool) is piped into the closure.
		bool: { || if $in { $colors.cyan } else { $colors.redDark } }
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
				$colors.redDark
			} else {
				$colors.red
			}
		}
		duration: white
		date: { || (date now) - $in |

			if $in < 1hr {
				$colors.red
			} else if $in < 6hr {
				$colors.redDark
			} else if $in < 1day {
				$colors.yellowDark
			} else if $in < 3day {
				$colors.yellow
			} else if $in < 1wk {
				$colors.greenBright
			} else if $in < 6wk {
				$colors.green
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
