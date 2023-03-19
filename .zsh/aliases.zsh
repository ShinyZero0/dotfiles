mkcd()
{
    mkdir -p "$1"
    cd "$1"
}

unabbr()
{
for abbr in $@
do
    abbr e -q $abbr &> /dev/null
done
}

alias reabbr="rip $HOME/.config/zsh-abbr/user-abbreviations && abbr import-aliases && unabbr rip bc which git"

alias lf="lfcd"
alias vi="nvim"
alias py="python"
alias bc='bc -q <(echo "scale=5")'
alias whrs="wormhole-rs"
alias mime="xdg-mime query filetype"


# ZSH
alias rez="exec zsh"
alias edz="$EDITOR ~/.zshrc"
alias eda="$EDITOR ~/.zsh/aliases.zsh"
alias q="exit"

# GIT
alias gc="git commit -m"
alias gca="git commit -am"
alias gcd="git add . && git commit -m"
alias gcl="git clone"
alias gst="git status"
alias gch="git checkout"
alias gdf="git diff"
alias gadd="git add"
alias gmenocom="git merge --no-commit --no-ff"
alias gcomall="git add --all && git commit"

gitt()
{
    if [[ $(exec git rev-parse --is-inside-work-tree 2>/dev/null) ]] then
        git $@
    else
        yadm $@
    fi
}
alias git="gitt"

# YADM
# alias yca="yadm commit -am"
# alias yst="yadm status"
# alias ych="yadm checkout"
# alias ydf="yadm diff"
# alias yadd="yadm add"

ddns="shinyzero.ddns.net"
