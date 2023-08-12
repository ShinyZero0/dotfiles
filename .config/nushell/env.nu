# Nushell Environment Config File

use ~/.config/nushell/scripts/utils.nu [
	Home,
]

let dataDir = (Home '.local/share/nushell')
mkdir $dataDir
# By default, <nushell-config-dir>/scripts is added
$env.NU_LIB_DIRS = [

	($nu.config-path | path dirname | path join 'scripts')
	($nu.config-path | path dirname | path join 'completions')
	$dataDir
]

$env.NU_PLUGIN_DIRS = [

    ($nu.config-path | path dirname | path join 'plugins')
]

$env.GH_USER = "ShinyZero0"
$env.EDITOR = 'nvim'
$env.IS_YADM = (
	$env.PROMPT?
		| default ""
		| str contains "yadm"
)
# for neovim
# $env.COLORSCHEME = if (
#
# 	$env.PROMPT?
# 	| default ""
# 	| str contains "yadm"
# ) {
# 	"cold"
# } else {
# 	"warm"
# }

# $env.NU_NQDIR = ( Home '.stuff/nq' )
$env.PLATES_DIR = ( Home '.stuff/plates' )

# User options

# used in some places e.g. focus.nu
$env.FUZZY_FINDER = "fzf"
$env.PAGER = "less -RF --incsearch --status-line --mouse --wheel-lines 3"
$env.MANPAGER = $env.PAGER
$env.DELTA_PAGER = $env.PAGER
$env.BAT_PAGER = $env.PAGER

# used for multiple selection
$env.FZF_DEFAULT_OPTS = (
	# DON'T REMOVE THE FUCKING TRAILING WHITESPACE
	[ 
		'--reverse',
		'--scheme=path',
		'--cycle',
		'--color=dark'
	]
	| str join " "
	| $in ++
	[
		'fg:#cbe3e7',
		'bg:#1b182c',
		'hl:#ff99e3',
		'fg+:#aaffe4',
		'bg+:#565575',
		'hl+:#63f2f1',
		'gutter:#1b182c',
		'pointer:#aaffe4',
		'prompt:#ff99e3',
		'info:#ffe9aa',
		'header:#cbe3e7',
		'spinner:#63f2f1'
	]
	| str join ","
)

# mkdir $env.NQDIR

# if ( $dataDir | path join 'zoxide.nu' | path exists ) {} else {
# 	zoxide init nushell | save ( $dataDir | path join 'zoxide.nu' )
# }
$env.LS_COLORS = ( open ~/.local/share/nushell/lscolors.txt )

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = { "> " }
$env.PROMPT_INDICATOR_VI_INSERT = { ": " }
$env.PROMPT_INDICATOR_VI_NORMAL = { "> " }
$env.PROMPT_MULTILINE_INDICATOR = { "::: " }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {

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
