# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# THE FOLLOWING LINES WERE ADDED BY COMPINSTALL
zstyle ':completion:*' menu select completer _complete _ignored _approximate
zstyle ':completion:*' max-errors 3
zstyle :compinstall filename '/home/zero/.zshrc'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

autoload -Uz compinit
compinit
zmodload zsh/complist

# LINES CONFIGURED BY ZSH-NEWUSER-INSTALL
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# ADDED BY ZINIT'S INSTALLER
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

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
    djui/alias-tips \
    romkatv/powerlevel10k \
    zdharma-continuum/fast-syntax-highlighting \
    jeffreytse/zsh-vi-mode \
    zsh-users/zsh-completions \
    ShinyZero0/z-git-filter \

zinit svn for \
    OMZP::gitfast \

zinit for \
    OMZL::git.zsh \

# PLUGS WITH BROKEN BINDS
zinit wait lucid for \
    atload:'bindkey "^[[A" history-substring-search-up' atload:'bindkey "^[[B" \
        history-substring-search-down' zsh-users/zsh-history-substring-search \
    hlissner/zsh-autopair

bindkey -M menuselect '^[[Z' reverse-menu-complete

zle_highlight+=(paste:none)

eval "$(zoxide init zsh)"

export EDITOR=nvim
export VISUAL=nvim
export FZF_DEFAULT_OPTS="--color=dark,fg:#cbe3e7,bg:#1b182c,hl:#c991e1,fg+:#aaffe4,bg+:#565575,hl+:#c991e1,gutter:#1b182c,pointer:#aaffe4,prompt:#c991e1,info:#ffe9aa,header:#cbe3e7,spinner:#63f2f1 --cycle --bind=tab:down,btab:up --reverse"
# unsetopt listambigious

source ~/.zshmob
source ~/.zshdesk
mkcd(){
    mkdir -p "$1"
    cd "$1"
}
# numbers=("${(@f)$(cmd)}")
alias rezsh="source ~/.zshrc"
alias edzsh="$EDITOR ~/.zshrc"
# GIT ALIASES
alias gcomall="git add --all && git commit"
alias gmgnocom="git merge --no-commit --no-ff"

alias xdgtype="xdg-mime query filetype"
alias camerasmooth="perl -i -pe 's/cameraSmooth.*/cameraSmooth:r=-1/' /home/zero/.steam/steam/steamapps/common/War\ Thunder/presets/РБ-танки.blk"
alias gst="git status"

setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
