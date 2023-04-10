# Void linux dotfiles

* packages are listed in [installation script](install.sh)
* info on making shit work listed in [WTF](WTF.md)

* key remapping tool i use is [xkeysnail](https://github.com/mooz/xkeysnail):
```bash
sudo pip install xkeysnail
sudo usermod -a -G input $USER # otherwise it will require global install and sudo
```
its config can be found [there](.config/xkeysnail.py)

Skim fuzzy finder:
```bash
cargo install skim
```

These are installed automatically by zinit:
* Plex Mono and InconsolataLGC Nerd Fonts

Use yadm for configs:
```bash
yadm clone git@github.com:ShinyZero0/dotfiles.git
```
