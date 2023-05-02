#  ╭──────────────────────────────────────────────────────────╮
#  │                Zinit installing stuff                    │
#  ╰──────────────────────────────────────────────────────────╯

# Install desktop-only apps
# zinit if="[[ $(uname -m) = x86_64 ]]" depth="1" as="null" from="gh-r" for \
#     sbin="fd" completions @sharkdp/fd \
#     sbin="btm" completions ClementTsang/bottom \
#     sbin="pistol* -> pistol" doronbehar/pistol \
#     sbin="choose* -> choose" theryangeary/choose \
#     sbin="wormhole-rs" magic-wormhole/magic-wormhole.rs \
#     bpick="kitty-*-x86_64.txz" sbin="bin/kitty" sbin="bin/kitten" \
#         kovidgoyal/kitty \
#     sbin="linux_czkawka_cli -> czkawka" bpick="linux_czkawka_cli" \
#         qarmin/czkawka \
#     sbin="OmniSharp -> omnisharp" bpick="omnisharp-linux-x64-net6.0.tar.gz" \
#         OmniSharp/omnisharp-roslyn

# Install non-release apps

zinit as="null" depth="1" for \
    atclone="mkcd build && cmake -DCMAKE_BUILD_TYPE=Release .. && cmake --build . --config Release" sbin="build/uncrustify" \
        uncrustify/uncrustify \
    sbin="nq" sbin="fq" atclone="make" \
        atpull="%atclone" \
        leahneukirchen/nq

    # sbin="jaro" isamert/jaro \
#     if="[[ $(uname -m) = x86_64 ]]" atclone="cargo install --path=." atpull="%atclone" I60R/page \
#     atclone="npm i ./" atpull="%atclone" sbin="bin/cli.js -> typograf-cli" typograf/typograf-cli \

# Install apps
# zinit as="null" depth"1" from="gh-r" \
#     for \
#     sbin="stylua" JohnnyMorganz/StyLua \
    # sbin="lf" gokcehan/lf \
    # sbin="fzf" junegunn/fzf \

