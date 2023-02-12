
### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
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
zinit for \
    light-mode \
        zdharma-continuum/zinit-annex-as-monitor \
        zdharma-continuum/zinit-annex-bin-gem-node \
        zdharma-continuum/zinit-annex-patch-dl \
        zdharma-continuum/zinit-annex-rust \
        wfxr/forgit \
        djui/alias-tips \

zinit svn for \
    OMZP::history-substring-search \
    OMZP::gitfast \

zinit for \
    OMZL::git.zsh \
    OMZP::sudo 

zinit compinit

### End of Zinit's installer chunk
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory

eval "$(zoxide init zsh)"
alias pkup="pkg upgrade -y"
alias pkfd="pkg search"
alias rezsh="source ~/.zshrc"
alias edzsh="$EDITOR ~/.zshrc"
mkcd(){
    mkdir -p "$1"
    cd "$1"
}
merge-no-add(){
    git merge --no-commit --no-ff "$1"
    addedFiles=("${(@f)$(git status -s | grep ^A | perl -pe 's/^A *//')}")
    for f in $addedFiles; do
        echo "Removed: $f"
        git restore --staged "$f"
    done
    echo "Commit now"
}
testfunc(){
    addedFiles=("$(git status -s | grep ^A | perl -pe 's/^A *//')")
    for f in $addedFiles; do
        echo $f
    done
}

