# Nushell Environment Config File

use ~/.config/nushell/scripts/utils.nu [
	Home,
]

# By default, <nushell-config-dir>/scripts is added
let-env NU_LIB_DIRS = [

	($nu.config-path | path dirname | path join 'scripts')
	($nu.config-path | path dirname | path join 'completions')
	(Home '.local/share/nushell')
]

let-env NU_PLUGIN_DIRS = [

    ($nu.config-path | path dirname | path join 'plugins')
]

let-env GH_USER = "ShinyZero0"
let-env EDITOR = 'nvim'
let-env IS_YADM = (
	$env.PROMPT?
		| default ""
		| str contains "yadm"
)
# for neovim
# let-env COLORSCHEME = if (
#
# 	$env.PROMPT?
# 	| default ""
# 	| str contains "yadm"
# ) {
# 	"cold"
# } else {
# 	"warm"
# }

let-env NQDIR = ( Home '.stuff/nq' )
let-env PLATES_DIR = ( Home '.stuff/plates' )

# User options

# used in some places e.g. focus.nu
let-env FUZZY_FINDER = "zf"
# used for multiple selection
let-env FZF_DEFAULT_OPTS = (
	[ 
		'--reverse',
		' --scheme=path',
		' --cycle',
		' --color=dark',
		',fg:#cbe3e7',
		',bg:#1b182c',
		',hl:#ff99e3',
		',fg+:#aaffe4',
		',bg+:#565575',
		',hl+:#63f2f1',
		',gutter:#1b182c',
		',pointer:#aaffe4',
		',prompt:#ff99e3',
		',info:#ffe9aa',
		',header:#cbe3e7',
		',spinner:#63f2f1',
	]
	| str join
)

mkdir $env.NQDIR
mkdir $env.SVDIR

let dataDir = $env.NU_LIB_DIRS.2
mkdir $dataDir
# if ( $dataDir | path join 'zoxide.nu' | path exists ) {} else {
# 	zoxide init nushell | save ( $dataDir | path join 'zoxide.nu' )
# }
let-env LS_COLORS = ( open ~/.local/share/nushell/lscolors.txt )

# The prompt indicators are environmental variables that represent
# the state of the prompt
let-env PROMPT_INDICATOR = { "> " }
let-env PROMPT_INDICATOR_VI_INSERT = { ": " }
let-env PROMPT_INDICATOR_VI_NORMAL = { "> " }
let-env PROMPT_MULTILINE_INDICATOR = { "::: " }

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

export alias r = exec nu
