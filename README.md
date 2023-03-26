# Installation

Install:

* packages:
```bash
sudo dnf install -y \
i3 polybar picom rofi \
python3-pip nodejs-npm cargo \
git yadm zsh sd zoxide \
xsel xclip neovim
```

* [xkeysnail](https://github.com/mooz/xkeysnail):
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
* [typograf](https://github.com/typograf/typograf-cli/) text formatter
* [bottom](https://github.com/ClementTsang/bottom) system monitor
* [choose](https://github.com/theryangeary/choose/)

Use yadm for configs:
```bash
yadm clone git@github.com:ShinyZero0/dotfiles.git
```
