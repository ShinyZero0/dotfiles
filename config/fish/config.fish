export EDITOR=nvim
export VISUAL=nvim
export MANPAGER=page
bind \b backward-kill-word
bind \e\[1\;5D backward-word
bind \e\[1\;5C forward-word
if status is-interactive
    # Commands to run in interactive sessions can go here
end
export FZF_DEFAULT_OPTS="--color=dark,fg:#cbe3e7,bg:#1b182c,hl:#c991e1,fg+:#aaffe4,bg+:#565575,hl+:#c991e1,gutter:#1b182c,pointer:#aaffe4,prompt:#c991e1,info:#ffe9aa,header:#cbe3e7,spinner:#63f2f1 --cycle --bind=tab:down,btab:up --reverse --exact"
