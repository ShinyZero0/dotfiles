# Void linux dotfiles

My configuration files for:
* i3wm
* lf file manager
* nushell
* neovim
* ... and some other stuff

XBPS packages are listed in [packages.json](.install/packages.json) which is automatically generated, more interesting ones which play well with nix are installed by nix home-manager

Instructions for myself about making shit work are in [WTF](WTF.md)

Use yadm for configs:
```bash
yadm clone git@github.com:ShinyZero0/dotfiles.git
```
Then look at installation script and install stuff, maybe even run the script and hope it's ready.
