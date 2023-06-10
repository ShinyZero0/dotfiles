# How to make shit work on Void linux and some other guides

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

With fcitx, but that doesn't work in some programs and games:
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

set `ui.key.menuAccessKeyFocuses` to false

## Readline bindings

Undo: <C-/>
To line start: <C-a>
To line end: <C-e>

## See pipe progress
xbps-install pv

## Clear nuget cache
```bash
dotnet nuget locals all --clear
```

## Make partition and filesystem and mount a flash drive

```bash
sudo
cfdisk /dev/sdc
mkfs.fat /dev/sdc1
cat << EOF >> /etc/fstab
UUID=$uuid /media/$mountpoint auto defaults,user,nofail 0 2
EOF
```
## Mount flash drives automatically
```bash
sudo
xbps-install udevil
# copy the service from ~/.config/sv/devmon
ln -s /etc/sv/devmon/run /var/service/
```

