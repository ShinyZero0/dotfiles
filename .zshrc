# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi


fpath+=~/.config/zsh/completions/

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

source ~/.config/zsh/alt.zsh
source ~/.config/zsh/lfcd.zsh
source ~/.config/zsh/aliases.zsh
source ~/.config/zsh/.p10k.zsh

# TURBO MODE
# zinit wait lucid depth="1" for \
#     zsh-users/zsh-history-substring-search \
#     hlissner/zsh-autopair \
#     ShinyZero0/z-git-filter \
#     RobSis/zsh-completion-generator \
#     olets/zsh-abbr \
#     OMZL::git.zsh \

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode depth="1" for \
    romkatv/powerlevel10k \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust \

# zinit wait depth="1" lucid for \
#     blockf atpull'zinit creinstall -q .' \
#     zsh-users/zsh-completions \
#     blockf completions \
#     https://github.com/TheLocehiliosan/yadm/raw/master/completion/zsh/_yadm \
#
source ~/.config/zsh/programs.zsh

eval "$(zoxide init zsh)"

zstyle ':completion:*' menu select completer _complete _ignored _approximate 
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
zstyle ':completion:*' max-errors 3
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle :compinstall filename '/home/zero/.zshrc'

# autoload -Uz compinit
# compinit
zmodload zsh/complist
# zinit compinit > /dev/null

bindkey -M menuselect '^[[Z' reverse-menu-complete
bindkey -M menuselect '\e' send-break
# zvm_bindkey viins '^H' 
# zvm_bindkey "\C-H" backward-kill-word

zle_highlight+=(paste:none)

setopt autocd menu_complete extendedglob
setopt HIST_EXPIRE_DUPS_FIRST HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_FIND_NO_DUPS HIST_SAVE_NO_DUPS SHARE_HISTORY
# INC_APPEND_HISTORY

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# RUN LAST

zinit wait lucid for \
    atload="zicompinit; zicdreplay" \
    atload:'bindkey "^[[A" history-substring-search-up' \
    atload:'bindkey "^[[B" history-substring-search-down' \
    zdharma-continuum/fast-syntax-highlighting \

