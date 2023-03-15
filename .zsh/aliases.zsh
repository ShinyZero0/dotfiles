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

alias lf="lfcd"
alias vi="nvim"
alias py="python"
alias bc='bc -q <(echo "scale=5")'
alias whrs="wormhole-rs"
alias mime="xdg-mime query filetype"

alias reabbr="rip $HOME/.config/zsh-abbr/user-abbreviations && abbr import-aliases && abbr erase rip"

# ZSH
alias rez="exec zsh"
alias edz="$EDITOR ~/.zshrc"
alias q="exit"

# GIT
alias gcl="git clone"
alias gca="git commit -am"
alias gst="git status"
alias gch="git checkout"
alias gdf="git diff | delta"
alias gadd="git add"
alias gmenocom="git merge --no-commit --no-ff"
alias gcomall="git add --all && git commit"

# YADM
alias yca="yadm commit -am"
alias yst="yadm status"
alias ych="yadm checkout"
alias ydf="yadm diff | delta"
alias yadd="yadm add"

ddns="shinyzero.ddns.net"
