#  ╭──────────────────────────────────────────────────────────╮
#  │                         Aliases                          │
#  ╰──────────────────────────────────────────────────────────╯

unabbr()
{
    for abbr in $@
    do
        abbr e -q $abbr &> /dev/null
    done
}

alias reabbr="\
    rip $HOME/.config/zsh-abbr/user-abbreviations \
    && abbr import-aliases \
    && unabbr rip bc which git"

alias gt="unalias git"
alias yd="alias git='yadm'"

alias zn="zinit"
alias lf="lfcd"
alias vi="nvim"
alias py="python"
alias whrs="wormhole-rs"
alias bc='bc -q <(echo "scale=5")'
alias mime="xdg-mime query filetype"


# ZSH
alias rez="exec zsh"
alias edz="$EDITOR ~/.zshrc"
alias eda="$EDITOR ~/.zsh/aliases.zsh"
alias q="exit"

# GIT
alias ga="git add"
alias gc="git commit -m"
alias gd="git diff"
alias gca="git commit -am"
alias gcd="git add . && git commit -m"
alias gcl="git clone"
alias gst="git status"
alias gch="git checkout"
alias gds="git diff --staged"
alias grs="git restore --staged"
alias grm="git rm --cached"
alias gmenocom="git merge --no-commit --no-ff"
alias gcomall="git add --all && git commit"

mkcd()
{
    mkdir -p "$1"
    cd "$1"
}

ddns="shinyzero.ddns.net"



