# How to make shit work on Void linux

## Make Steam work 

```bash
xbps-install -S void-repo-multilib{,-nonfree}
xbps-install steam
```

For mesa users this would result in:
```bash
xbps-install -S libgcc-32bit libstdc++-32bit libdrm-32bit libglvnd-32bit mesa-dri-32bit
```
## Add keyboard layouts

With fcitx, but that doesn't work in some programs e.g. games:
```bash
xbps-install fcitx5
```

With setxkbmap:
```bash
setxkbmap -layout us,ru -option 'grp:alt_shift_toggle'
```

## Make nix work

```bash
sudo ln -s /etc/sv/nix-daemon/ /var/service 
nix-channel --add https://nixos.org/channels/nixpkgs-unstable 
nix-channel --update 
```

## Install Firefox developer edition

```bash
nix-env -i firefox-devedition-bin
```

### Disable alt menu through [config](about:config)
set `ui.key.menuAccessKeyFocuses` to false

## Readline bindings

Undo: <C-/>
To line start: <C-a>
To line end: <C-e>

