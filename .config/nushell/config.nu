# Nushell Config File
#
# version = 0.78.1

let external_completer = { |spans|
	{
		dotnet: { || 

			dotnet complete (
				$spans | skip 1 | str join " "
			) | lines
		}
	} 
	| get $spans.0 | each { || do $in }
}


# The default config record. This is where much of your global configuration is setup.
let-env config = {

	show_banner: false
	ls: {

		use_ls_colors: true # use the LS_COLORS environment variable to colorize output
		clickable_links: true # enable or disable clickable links. Your terminal has to support links.
	}
	rm: {

		always_trash: true # always act as if -t was given. Can be overridden with -p
	}
	cd: {

		abbreviations: false # allows `cd s/o/f` to expand to `cd some/other/folder`
	}
	table: {

		mode: rounded # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
		index_mode: auto # "always" show indexes, "never" show indexes, "auto" = show indexes when a table has "index" column
		show_empty: true # show 'empty list' and 'empty record' placeholders for command output
		trim: {

			methodology: wrapping # wrapping or truncating
			wrapping_try_keep_words: true # A strategy used by the 'wrapping' methodology
			truncating_suffix: "..." # A suffix used by the 'truncating' methodology
		}
	}

	explore: {

		help_banner: true
		exit_esc: true

		command_bar_text: '#C4C9C6'
		# command_bar: { fg: '#C4C9C6' bg: '#223311' }

		status_bar_background: { fg: '#1D1F21' bg: '#C4C9C6' }
		# status_bar_text: { fg: '#C4C9C6' bg: '#223311' }

		highlight: { bg: 'yellow' fg: 'black' }

		status: {

			# warn: { bg: 'yellow', fg: 'blue' }
			# error: { bg: 'yellow', fg: 'blue' }
			# info: { bg: 'yellow', fg: 'blue' }
		}

		try: {

			# border_color: 'red'
			# highlighted_color: 'blue'

			# reactive: false
		}

		table: {

			split_line: '#404040'

			cursor: true

			line_index: true
			line_shift: true
			line_head_top: true
			line_head_bottom: true

			show_head: true
			show_index: true

			# selected_cell: { fg: 'white', bg: '#777777' }
			# selected_row: { fg: 'yellow', bg: '#C1C2A3' }
			# selected_column: blue

			# padding_column_right: 2
			# padding_column_left: 2

			# padding_index_left: 2
			# padding_index_right: 1
		}

		config: {

			cursor_color: { bg: 'yellow' fg: 'black' }

			# border_color: white
			# list_color: green
		}
	}

	history: {

		max_size: 1000000 # Session has to be reloaded for this to take effect
		sync_on_enter: true # Enable to share history between multiple sessions, else you have to close the session to write history to file
		file_format: "sqlite" # "sqlite" or "plaintext"
	}
	completions: {

		case_sensitive: false # set to true to enable case-sensitive completions
		quick: true  # set this to false to prevent auto-selecting completions when only one remains
		partial: true  # set this to false to prevent partial filling of the prompt
		algorithm: "prefix"  # prefix or fuzzy
		external: {

			enable: true # set to false to prevent nushell looking into $env.PATH to find more suggestions, `false` recommended for WSL users as this look up my be very slow
			max_results: 100500 # setting it lower can improve completion performance at the cost of omitting some options
			completer: $external_completer # check 'carapace_completer' above as an example
		}
	}
	filesize: {

		metric: true # true => KB, MB, GB (ISO standard), false => KiB, MiB, GiB (Windows standard)
		format: "auto" # b, kb, kib, mb, mib, gb, gib, tb, tib, pb, pib, eb, eib, zb, zib, auto
	}
	cursor_shape: {

		emacs: underscore # block, underscore, line (line is the default)
		vi_insert: line # block, underscore, line (block is the default)
		vi_normal: block # block, underscore, line  (underscore is the default)
	}
	use_grid_icons: true
	footer_mode: "25" # always, never, number_of_rows, auto
	float_precision: 2 # the precision for displaying floats in tables
	# buffer_editor: "emacs" # command that will be used to edit the current line buffer with ctrl+o, if unset fallback to $env.EDITOR and $env.VISUAL
	use_ansi_coloring: true
	edit_mode: vi # emacs, vi
	shell_integration: true # enables terminal markers and a workaround to arrow keys stop working issue
	render_right_prompt_on_last_line: false # true or false to enable or disable right prompt to be rendered on last line of the prompt.

	# TODO: dump packages after installing/deleting
	hooks: {

		pre_prompt: [{ ||
			let direnv = (direnv export json | from json)
			let direnv = if ($direnv | length) == 1 { $direnv } else { { } }
			$direnv | load-env
		}]
		pre_execution: [{ ||
			null  # replace with source code to run before the repl input is run
		}]
		env_change: {

			PWD: [{ |before, after|
				# if ( './zellij.kdl' | path exists ) {
				# 	~/.scripts/zellij-env.nu
				# }
			}]
		}
		display_output: { ||
			if (term size).columns >= 50 { table -e } else { table }
		}
		command_not_found: { |command| (

			if not (which xlocate | is-empty) {

				let pkgs = (xlocate $"bin/($command)$" | lines | each { |x| $x | parse '{pkg} {bin}' | get pkg | to text } | to text  )
				if not ($pkgs | is-empty) {
					( "This executable can be found in the following packages:\n" + $pkgs)
				} else {
					"Xlocate failed to find this executable"
				}
			}
		) }
	}
	menus: [

		# Configuration for default nushell menus
		# Note the lack of source parameter
		{
			name: completion_menu
			only_buffer_difference: false
			marker: "| "
			type: {

				layout: columnar
				columns: 4
				col_width: 20   # Optional value. If missing all the screen width is used to calculate column width
				col_padding: 2
			}
			style: {

				text: green
				selected_text: green_reverse
				description_text: yellow
			}
		}
		{
			name: history_menu
			only_buffer_difference: true
			marker: "? "
			type: {

				layout: list
				page_size: 20
			}
			style: {

				text: green
				selected_text: green_reverse
				description_text: yellow
			}
		}
		{
			name: help_menu
			only_buffer_difference: true
			marker: "? "
			type: {

				layout: description
				columns: 4
				col_width: 20   # Optional value. If missing all the screen width is used to calculate column width
				col_padding: 2
				selection_rows: 4
				description_rows: 10
			}
			style: {

				text: green
				selected_text: green_reverse
				description_text: yellow
			}
		}
		# Example of extra menus created using a nushell source
		# Use the source field to create a list of records that populates
		# the menu
		{
			name: commands_menu
			only_buffer_difference: false
			marker: "# "
			type: {

				layout: columnar
				columns: 4
				col_width: 20
				col_padding: 2
			}
			style: {

				text: green
				selected_text: green_reverse
				description_text: yellow
			}
			source: { |buffer, position|
				$nu.scope.commands
				| where name =~ $buffer
				| each { |it| { value: $it.name description: $it.usage } }
			}
		}
		{
			name: vars_menu
			only_buffer_difference: true
			marker: "# "
			type: {

				layout: list
				page_size: 10
			}
			style: {

				text: green
				selected_text: green_reverse
				description_text: yellow
			}
			source: { |buffer, position|
				$nu.scope.vars
				| where name =~ $buffer
				| sort-by name
				| each { |it| { value: $it.name description: $it.type } }
			}
		}
		{
			name: commands_with_description
			only_buffer_difference: true
			marker: "# "
			type: {

				layout: description
				columns: 4
				col_width: 20
				col_padding: 2
				selection_rows: 4
				description_rows: 10
			}
			style: {

				text: green
				selected_text: green_reverse
				description_text: yellow
			}
			source: { |buffer, position|
				$nu.scope.commands
				| where name =~ $buffer
				| each { |it| { value: $it.name description: $it.usage } }
			}
		}
	]
	keybindings: [

		{
			name: completion_menu
			modifier: none
			keycode: tab
			mode: [emacs vi_normal vi_insert]
			event: {

				until: [

					{ send: menu name: completion_menu }
					{ send: menunext }
				]
			}
		}
		{
			name: completion_previous
			modifier: shift
			keycode: backtab
			mode: [emacs, vi_normal, vi_insert] # Note: You can add the same keybinding to all modes by using a list
			event: { send: menuprevious }
		}
		{
			name: unix-line-discard
			modifier: control
			keycode: char_u
			mode: [emacs, vi_normal, vi_insert]
			event: {
				until: [
					{ edit: cutfromlinestart }
				]
			}
		}
		{
			name: kill-line
			modifier: control
			keycode: char_k
			mode: [emacs, vi_normal, vi_insert]
			event: {

				until: [

					{ edit: CutToLineEnd }
				]
			}
		}

		# Keybindings used to trigger the user defined menus
		{
			name: commands_menu
			modifier: control
			keycode: char_t
			mode: [emacs, vi_normal, vi_insert]
			event: { send: menu name: commands_menu }
		}
		{
			name: vars_menu
			modifier: alt
			keycode: char_o
			mode: [emacs, vi_normal, vi_insert]
			event: { send: menu name: vars_menu }
		}
		{
			name: commands_with_description
			modifier: control
			keycode: char_s
			mode: [emacs, vi_normal, vi_insert]
			event: { send: menu name: commands_with_description }
		}
		{
			name: find_file
			modifier: control
			keycode: char_f
			mode: [emacs, vi_normal, vi_insert]
			event: [
				{ 
					send: executehostcommand 
					cmd: "_finderHydra" 
				}
			]

		}
	]
}

use theme.nu *
# Use nushell functions to define your right and left prompt
let-env PROMPT_COMMAND = { || create_left_prompt }
let-env PROMPT_COMMAND_RIGHT = { || create_right_prompt }
$env.config.color_config = ( GetDarkTheme )

source aliases/aliases-pre.nu
source aliases/git.nu
use aliases/xbps.nu *

use commands.nu *

source zoxide.nu
source alt.nu
source langTools.nu
source focus.nu
source hydra.nu

use nq-utils.nu *
use move-and-replace.nu *

use git-completions.nu *
use nix-completions.nu *
use make-completions.nu *
use xbps-cmp.nu *
use man-cmp.nu *
use termux-pkg-cmp.nu *
use zellij-cmp.nu *
use proc-cmp.nu *
use udevil-cmp.nu *
use gh-cmp.nu *
use nx.nu *

source aliases/aliases-post.nu

source init.nu
