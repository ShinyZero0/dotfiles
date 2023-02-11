# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# The following lines were added by compinstall

zstyle ':completion:*' menu select completer _complete _ignored _approximate
zstyle ':completion:*' max-errors 3
zstyle :compinstall filename '/home/zero/.zshrc'

autoload -Uz compinit
compinit
zmodload zsh/complist
# End of lines added by compinstall
#
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# bindkey -e
# End of lines configured by zsh-newuser-install

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

eval "$(zoxide init zsh)"
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust \
    
### End of Zinit's installer chunk
# zinit light spaceship-prompt/spaceship-prompt

zinit light romkatv/powerlevel10k
zinit load zdharma-continuum/fast-syntax-highlighting
zinit light jeffreytse/zsh-vi-mode
zinit light MichaelAquilina/zsh-auto-notify

# plugs with broken binds
zinit ice wait lucid atload'bindkey "^[[A" history-substring-search-up' atload'bindkey "^[[B" history-substring-search-down'
zinit light zsh-users/zsh-history-substring-search
zinit ice wait lucid
zinit light hlissner/zsh-autopair

bindkey -M menuselect '^[[Z' reverse-menu-complete

zle_highlight+=(paste:none)

mkcdir() {
    mkdir $1
    cd $1
}
alias xdgtype="xdg-mime query filetype"

path+=/home/zero/bin/ 
path+=/home/zero/.local/bin/
export PATH
export EDITOR=nvim
export VISUAL=nvim
export FZF_DEFAULT_OPTS="--color=dark,fg:#cbe3e7,bg:#1b182c,hl:#c991e1,fg+:#aaffe4,bg+:#565575,hl+:#c991e1,gutter:#1b182c,pointer:#aaffe4,prompt:#c991e1,info:#ffe9aa,header:#cbe3e7,spinner:#63f2f1 --cycle --bind=tab:down,btab:up --reverse --exact"

setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
