# Installation

Install:

* packages:
```bash
sudo dnf install -y \
i3 polybar picom rofi \
python3-pip nodejs-npm cargo cmake \
git yadm zsh sd zoxide \
xsel xclip neovim
```

* [xkeysnail](https://github.com/mooz/xkeysnail) key remapping tool:
```bash
sudo pip install xkeysnail
sudo usermod -a -G input $USER
```


Skim fuzzy finder:
```bash
cargo install skim
```

These are installed automatically by zinit:
* [kitty](https://github.com/kovidgoyal/kitty) terminal emulator
* [lf](https://github.com/gokcehan/lf) file browser
* [pistol](https://github.com/doronbehar/pistol) file previewer
* [jaro](https://github.com/isamert/jaro) file opener
* [fd](https://github.com/sharkdp/fd) file finder
* [fzf](https://github.com/junegunn/fzf) fuzzy finder
* [page](https://github.com/I60R/page) neovim as pager
* [czkawka](https://github.com/qarmin/czkawkahttps://github.com/qarmin/czkawka) cleaning utility
* [wormhole-rs](https://github.com/magic-wormhole/magic-wormhole.rs) file transfer utility
* [bottom](https://github.com/ClementTsang/bottom) system monitor
* [typograf](https://github.com/typograf/typograf-cli/) text formatter
* [uncrustify](https://github.com/uncrustify/uncrustify/) code formatter
* [omnisharp](https://github.com/OmniSharp/omnisharp-roslyn) C# LSP
* [stylua](https://github.com/JohnnyMorganz/StyLua) lua formatter
* [choose](https://github.com/theryangeary/choose/)
* Plex Mono and InconsolataLGC Nerd Fonts

Use yadm for configs:
```bash
yadm clone git@github.com:ShinyZero0/dotfiles.git
```
