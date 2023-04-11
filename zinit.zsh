#!/usr/bin/env zsh

source ~/.local/share/zinit/zinit.git/zinit.zsh
# for file in ~/.local/share/zinit/zinit.git/*; do
#     source "$file"
# done
zinit light-mode depth="1" for \
    zdharma-continuum/zinit-annex-bin-gem-node \
    # zdharma-continuum/zinit-annex-patch-dl \
    # zdharma-continuum/zinit-annex-rust \
    # zdharma-continuum/zinit-annex-as-monitor \

source ~/.config/zsh/programs.zsh
zinit "$@"
