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
    rm $HOME/.config/zsh-abbr/user-abbreviations \
    && abbr import-aliases \
    && unabbr bc which git z zi"

alias yd="yadm enter exec zsh"
alias camerasmooth="perl -i -pe 's/cameraSmooth.*/cameraSmooth:r=-1/' $HOME/.config/WarThunder/Controls/TankRB.blk"
alias winclass="xprop WM_CLASS"
alias dn="dotnet"

# shortenings
alias zn="zinit"
alias vi="nvim"
alias py="python"
alias bc='bc -q <(echo "scale=5")'
alias mime="xdg-mime query filetype"

# sane defaults
alias duf="duf -only local"
alias ls="ls --color=auto -H"
alias la="ls -A"
alias ll="ls -lh"
alias lla="ls -lhA"
alias grep="grep --color=auto"

# ZSH
alias r="exec zsh"
alias edz='$EDITOR ~/.zshrc'

# GIT
alias ga="git add"
alias gc="git commit -m"
alias gd="git diff"
alias gca="git commit --amend"
alias gcl="git clone"
alias gst="git status"
alias gch="git checkout"
alias gds="git diff --staged"
alias grss="git restore --staged"
alias grmc="git rm --cached"

mkcd()
{
    mkdir -p "$1"
    cd "$1"
}
ungit-cb()
{
	xsel -ob \
	| awk -F "[/#]" '{print $4 "/" $5}' \
	| xsel -ib --trim
}
