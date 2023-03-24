# Installation

Install:

* packages:
```bash
sudo dnf install -y \
i3 polybar picom rofi \
python3-pip node-npm cargo \
git yadm zsh \
xsel xclip neovim
```
* [xkeysnail](https://github.com/mooz/xkeysnail):
```bash
sudo pip install xkeysnail
sudo usermod -a -G input $USER
```

These are installed automatically by zinit:
* [lf](https://github.com/gokcehan/lf) file browser
* [pistol](https://github.com/doronbehar/pistol) file previewer
* [jaro](https://github.com/isamert/jaro) file opener
* [fd](https://github.com/sharkdp/fd) file finder
* [fzf](https://github.com/junegunn/fzf) fuzzy finder
* [kitty](https://github.com/kovidgoyal/kitty) terminal emulator
* [page](https://github.com/I60R/page) neovim as pager
* [czkawka](https://github.com/qarmin/czkawkahttps://github.com/qarmin/czkawka) cleaning utility
* [wormhole-rs](https://github.com/magic-wormhole/magic-wormhole.rs) file transfer utility
* [glow](https://github.com/charmbracelet/glow) markdown previewer
* [typograf](https://github.com/typograf/typograf-cli/) text formatter


Set [Challenger Deep](https://github.com/challenger-deep-theme/xresources) as xresources  
```bash
wget -O ~/.Xresources https://raw.githubusercontent.com/challenger-deep-theme/xresources/master/challenger-deep.xdefaults
```
Install with yadm: `yadm clone https://github.com/ShinyZero0/dotfiles.git`
