# Nushell Environment Config File
#
# version = 0.78.1

def create_left_prompt [] {

    mut home = ""
    try {

        if $nu.os-info.name == "windows" {

            $home = $env.USERPROFILE
        } else {

            $home = $env.HOME
        }
    }

    let dir = ([

        ($env.PWD | str substring 0..($home | str length) | str replace -s $home "~"),
        ($env.PWD | str substring ($home | str length)..)
    ] | str join)

    let path_segment = if (is-admin) {

        $"(ansi red_bold)($dir)"
    } else if ($env.PROMPT? | default "zero" | str contains "yadm") {

        $"(ansi green_bold)($dir)(ansi red_bold) yadm"
    } else {

        $"(ansi green_bold)($dir)"
    }

    $path_segment
}

def create_right_prompt [] {

    let time_segment = ([

        (ansi reset)
        (ansi magenta)
        (date now | date format '%r')
    ] | str join)
    let last_exit_code = if ($env.LAST_EXIT_CODE != 0) {([

        (ansi rb)
        ($env.LAST_EXIT_CODE)
    ] | str join)
    } else { "" }

    ([$last_exit_code, (char space), $time_segment] | str join)
}

# Use nushell functions to define your right and left prompt
let-env PROMPT_COMMAND = {|| create_left_prompt }
let-env PROMPT_COMMAND_RIGHT = {|| create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
let-env PROMPT_INDICATOR = {|| "> " }
let-env PROMPT_INDICATOR_VI_INSERT = {|| ": " }
let-env PROMPT_INDICATOR_VI_NORMAL = {|| "> " }
let-env PROMPT_MULTILINE_INDICATOR = {|| "::: " }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
let-env ENV_CONVERSIONS = {

  "PATH": {

    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
  "Path": {

    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
let-env NU_LIB_DIRS = [

    ($nu.config-path | path dirname | path join 'scripts')
    ($nu.config-path | path dirname | path join 'completions')
    ($env.HOME | path join '.local/share/nushell')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added

let-env NU_PLUGIN_DIRS = [

    ($nu.config-path | path dirname | path join 'plugins')
]

let-env NU_CMP_DIRS = [

    ($nu.config-path | path dirname | path join 'completions')
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# let-env PATH = ($env.PATH | split row (char esep) | prepend '/some/path')

let-env SVDIR = '~/.config/sv/'
let-env EDITOR = 'nvim'
let-env NQDIR = '~/.stuff/nq/'
mkdir $env.NQDIR

let NU_APPDATA_DIR = ($env.HOME | path join '.local/share/nushell')
mkdir $NU_APPDATA_DIR
zoxide init nushell | save -f ( $NU_APPDATA_DIR | path join 'zoxide.nu' )

# let-env PAGER = 'page -t man' 
# let-env MANPAGER = 'page -t man'
