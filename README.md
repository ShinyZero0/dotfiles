# Installation

Install:

* packages:
```bash
sudo dnf install i3wm polybar picom rofi python3-pip -y
```
* [xkeysnail](https://github.com/mooz/xkeysnail):
```bash
sudo pip install xkeysnail
sudo usermod -a -G input $USER
```

These are installed automatically by zinit:
* [lf](https://github.com/gokcehan/lf)
* [pistol](https://github.com/doronbehar/pistol)
* [jaro](https://github.com/isamert/jaro)
* [kitty](https://github.com/kovidgoyal/kitty)

Set [Challenger Deep](https://github.com/challenger-deep-theme/xresources) as xresources  
```bash
wget -O ~/.Xresources https://raw.githubusercontent.com/challenger-deep-theme/xresources/master/challenger-deep.xdefaults
```
Install with yadm: `yadm clone https://github.com/ShinyZero0/dotfiles.git`
