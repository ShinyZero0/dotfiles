# Installation

Install:

* packages:
```bash
sudo dnf install i3wm polybar picom rofi kitty python3-pip -y
```
* [xkeysnail](https://github.com/mooz/xkeysnail):
```bash
sudo pip3 install xkeysnail
sudo usermod -a -G input $USER
```
* [lf](https://github.com/gokcehan/lf)
* [pistol](https://github.com/doronbehar/pistol)
* [jaro](https://github.com/isamert/jaro) 

Set [Challenger Deep](https://github.com/challenger-deep-theme/xresources) as xresources  
```bash
wget -O ~/.Xresources https://raw.githubusercontent.com/challenger-deep-theme/xresources/master/challenger-deep.xdefaults
```
Install with yadm: `yadm clone https://github.com/ShinyZero0/dotfiles.git`
