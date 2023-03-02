# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi


fpath+=~/.zsh/completions/

mkcd(){
    mkdir -p "$1"
    cd "$1"
}

alias lf="lfcd"

alias rcupv="rcup -v | rg -v 'identical' "

alias rez="source ~/.zshrc"
alias edz="$EDITOR ~/.zshrc"

alias whrs="wormhole-rs"

alias xdgtype="xdg-mime query filetype"

# GIT ALIASES
alias gcomall="git add --all && git commit"
alias gca="git commit -a"
alias gmenocom="git merge --no-commit --no-ff"
alias gst="git status"
alias gch="git checkout"
alias yst="yadm status"
alias yadd="yadm add"
alias yca="yadm commit -a"

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

source ~/.zsh-alt
source ~/.zsh/lfcd.zsh

# TURBO MODE
zinit wait lucid depth"1" for \
    atload:'bindkey "^[[A" history-substring-search-up' \
    atload:'bindkey "^[[B" history-substring-search-down' \
        zsh-users/zsh-history-substring-search \
    hlissner/zsh-autopair \
    ShinyZero0/z-git-filter \
    RobSis/zsh-completion-generator \
    olets/zsh-abbr \

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode depth"1" for \
        romkatv/powerlevel10k \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust \


# Install Desktop-only binaries
zinit if"[[ $(uname -m) = x86_64 ]]" as"null" from"gh-r" for \
    bpick"kitty-*-x86_64.txz" sbin"bin/kitty" sbin"bin/kitten" \
        kovidgoyal/kitty \
    sbin"pistol* -> pistol" \
        doronbehar/pistol \
    sbin"linux_czkawka_cli -> czkawka" bpick"linux_czkawka_cli" \
        qarmin/czkawka \
    sbin"koreader* -> koreader" \
        koreader/koreader \
    sbin"wormhole-rs" magic-wormhole/magic-wormhole.rs
    sbin"fd" completions @sharkdp/fd \

    # sbin"deno" denoland/deno \

# Install binaries
zinit as"null" depth"1" from"gh-r" for \
    sbin"lf" gokcehan/lf \
    sbin"glow" charmbracelet/glow \
    sbin"fzf" junegunn/fzf \

# Install non-release binaries
zinit as"null" depth"1" for \
    sbin"jaro" isamert/jaro \
    atclone"cargo install --path=." atpull"%atclone" I60R/page

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

zinit for \
    OMZL::git.zsh \

zinit wait depth"1" lucid for \
    blockf atpull'zinit creinstall -q .' \
        zsh-users/zsh-completions \
    blockf completions \
        https://github.com/TheLocehiliosan/yadm/raw/master/completion/zsh/_yadm \

eval "$(zoxide init zsh)"

zstyle ':completion:*' menu select completer _complete _ignored _approximate
zstyle ':completion:*' max-errors 3
zstyle :compinstall filename '/home/zero/.zshrc'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# autoload -Uz compinit
# compinit
zmodload zsh/complist
# zinit compinit > /dev/null

bindkey -M menuselect '^[[Z' reverse-menu-complete

zle_highlight+=(paste:none)

setopt autocd

setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
# setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

zinit wait lucid for \
    atload"zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
