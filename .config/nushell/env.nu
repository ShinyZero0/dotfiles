# Nushell Environment Config File
#
# version = 0.78.1

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
use ~/.config/nushell/scripts/utils.nu [
	_home,
	ansi-tmp
] 

let-env NU_LIB_DIRS = [

    ($nu.config-path | path dirname | path join 'scripts')
    ($nu.config-path | path dirname | path join 'completions')
	(_home '.local/share/nushell')
]

let-env NU_PLUGIN_DIRS = [

    ($nu.config-path | path dirname | path join 'plugins')
]

let-env XDG_DATA_DIRS = (
	$env.XDG_DATA_DIRS? | default [] 
		| prepend ( _home .nix-profile/share ) 
		| prepend /usr/local/share 
		| prepend /usr/share/
)
let-env EDITOR = 'nvim'
let-env SVDIR = ( _home '.config/sv' )
let-env NQDIR = ( _home '.stuff/nq' )
let-env PLATES_DIR = ( _home '.stuff/plates' )
mkdir $env.NQDIR
mkdir $env.SVDIR

mkdir $env.NU_LIB_DIRS.2
zoxide init nushell | save -f ( $env.NU_LIB_DIRS.2 | path join 'zoxide.nu' )

let-env PAGER = moar
let-env MANPAGER = moar

def create_left_prompt [] {

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

    let path_segment = ( ansi-tmp $dir gb )
    let yadm_segment = if (
		$env.PROMPT? 
		| default "" 
		| str contains "yadm"
    ) {
		[
			( ansi-tmp "@" light_cyan_bold )
			( ansi-tmp "yadm" red_bold )
		]
		| str join
    } 
    let nix_segment = if (
		$env.PATH | any { ||
			str contains "/nix/store"
		}
    ) {
		ansi-tmp "  " blue
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

def create_right_prompt [] {

    let time_segment = (
        [ (
			ansi-tmp (date now | date format '%r') magenta
		) ] 
        | str join
    )
    let last_exit_code = if ( $env.LAST_EXIT_CODE != 0 ) { 
		[
            ( ansi-tmp $env.LAST_EXIT_CODE r )
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

# Use nushell functions to define your right and left prompt
let-env PROMPT_COMMAND = { || create_left_prompt }
let-env PROMPT_COMMAND_RIGHT = { || create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
let-env PROMPT_INDICATOR = { || "> " }
let-env PROMPT_INDICATOR_VI_INSERT = { || ": " }
let-env PROMPT_INDICATOR_VI_NORMAL = { || "> " }
let-env PROMPT_MULTILINE_INDICATOR = { || "::: " }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
let-env ENV_CONVERSIONS = {

  "PATH": {

    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
  "XDG_DATA_DIRS": {

    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
}

