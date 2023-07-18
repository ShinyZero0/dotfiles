# Void linux dotfiles

My configuration files for:

* bspwm
* neovim
* nushell
* ... and some other stuff

XBPS packages are listed in [packages.json](.install/packages.json) which is automatically generated, more interesting ones which play well with nix are installed by nix home-manager

Instructions for myself about making shit work are in [WTF](WTF.md)

Use yadm for configs:

```bash
yadm clone git@github.com:ShinyZero0/dotfiles.git
```

Then look at installation script and install stuff, you can even run the script and hope it's ready for usage.
Btw the [wallpapers script](~/.config/sv/wallpapers/run) depends on my anime pictures on 2nd drive.
You should put your anime collection there.
