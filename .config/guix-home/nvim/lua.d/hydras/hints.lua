-- stylua: ignore
return {
	-- {{{
	Telescope = [[
    Telescope:

    _f_: Files       _r_: Old files
    _g_: Grep all    _b_: Buffers

    _h_: Headings    _/_: Grep this
    _'_: Marks       _q_: Quickfix

    _j_: Jumplist    _"_: Clipboard history

    _l_: highLights  _O_: Options    
    _?_: Help tags   _k_: Keymaps    
    
    _c_: Commands history _;_: execute Command    

    _<Enter>_: Builtin           _<Esc>_
    ]], -- }}}
	-- {{{
	Options = [[
    Options:

    _w_: wrap      %{wrap}
    _b_: linebreak %{lb}
    _R_: readonly  %{ro}
	_+_, _-_: tabstop +-1
    _C_: Colorizer
    _t_: filetype: %{ft}    
    _L_: Lazy.nvim

    _q_, _<Esc>_, _<C-q>_    
    ]], -- }}}
	-- {{{
	Formatting = [[
    Formatting

    _._: Default Formatter    
    _r_: To Russian
    _e_: To English
    _s_: Split
    _j_: Join

    ]], -- }}}
	-- {{{
	SaveOrExit = [[
_<C-s>_,_s_: Save and quit
_<C-q>_,_q_: Quit without saving]], -- }}}
}
