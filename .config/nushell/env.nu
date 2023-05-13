# Nushell Environment Config File
#
# version = 0.78.1

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
use ~/.config/nushell/scripts/utils.nu [
	_home,
	_ansiTmp
] 

let-env NU_LIB_DIRS = [

    ($nu.config-path | path dirname | path join 'scripts')
    ($nu.config-path | path dirname | path join 'completions')
	(_home '.local/share/nushell')
]

let-env NU_PLUGIN_DIRS = [

    ($nu.config-path | path dirname | path join 'plugins')
]

# let-env XDG_DATA_DIRS = (
# 	$env.XDG_DATA_DIRS? | default [] 
# 		| prepend /usr/local/share 
# 		| prepend /usr/share/
# 		| prepend ( _home .nix-profile/share ) 
# 		| uniq
# )
let-env GH_USER = "ShinyZero0"
let-env EDITOR = 'nvim'
let-env SVDIR = ( _home '.local/share/service' )
let-env NQDIR = ( _home '.stuff/nq' )
let-env PLATES_DIR = ( _home '.stuff/plates' )
mkdir $env.NQDIR
mkdir $env.SVDIR

let dataDir = $env.NU_LIB_DIRS.2
mkdir $dataDir
if ( $dataDir | path join 'zoxide.nu' | path exists ) {} else {
	zoxide init nushell | save ( $dataDir | path join 'zoxide.nu' )
}
let-env LS_COLORS = ( vivid generate snazzy )

let-env PAGER = moar
let-env MANPAGER = moar

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

