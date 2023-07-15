# How to make shit work on Void linux and some other guides

# Make Steam work 

```bash
xbps-install -S void-repo-multilib{,-nonfree}
xbps-install steam
```

For mesa users this would result in:
```bash
xbps-install -S libgcc-32bit libstdc++-32bit libdrm-32bit libglvnd-32bit mesa-dri-32bit
```
# Add keyboard layouts

With fcitx, but that doesn't work in some programs and games:
```bash
xbps-install fcitx5
```

With setxkbmap:
```bash
setxkbmap -layout us,ru -option 'grp:alt_shift_toggle'
```

# Make nix work

```bash
sudo ln -s /etc/sv/nix-daemon/ /var/service 
nix-channel --add https://nixos.org/channels/nixpkgs-unstable 
nix-channel --update 
```

set `ui.key.menuAccessKeyFocuses` to false

# Readline bindings

Undo: <C-/>
To line start: <C-a>
To line end: <C-e>

# See pipe progress

install http://www.ivarch.com/programs/pv.shtml
pv is a pipe viewer

# Clear nuget cache

```bash
dotnet nuget locals all --clear
```

# Make partition and filesystem and mount a flash drive

```bash
sudo
cfdisk /dev/sdc
mkfs.fat /dev/sdc1
cat << EOF >> /etc/fstab
UUID=$uuid /media/$mountpoint auto defaults,user,nofail 0 2
EOF
```

# Mount flash drives automatically

```bash
sudo
xbps-install udevil
# copy the service from ~/.config/sv/devmon
ln -s /etc/sv/devmon/run /var/service/
```

# Port forwarding

> xwindows:
"commonly used when one needs to expose some server which listens only on localhost to LAN (my case) or to
internet?", I think a common one on *nix is `socat`.
Alternatively, if you are into GNU/Linux netadmin mojo, you can also use `iptables`/`nftables` + `ip route`
sorcery to set up NAT'ish port-forwarding that looks more "real" (i.e. remote address-preserving) to the software you use.

## Make Kestrel listen for external requests

That was the X problem of Y problem above actually
In `appsettings.json` file near to the executable
use 0.0.0.0 instead of localhost or 127.0.0.1

```json
{
  "Kestrel": {
    "Endpoints": {
      "Http": {
        "Url": "http://0.0.0.0:5000"
      }
    },
  }
}
```

# Configure x11 sleep

```bash
xset -s on
xset -s off
```

# Pipewire + pulse network streaming through rtp

```bash
pactl unload-module module-null-sink
pactl unload-module module-rtp-send
pactl load-module module-null-sink sink_name=rtp format=s16be channels=2 rate=48000
pactl load-module module-rtp-send source=rtp.monitor destination=224.0.0.56 port=4010 mtu=320
```

# Zswap

```bash
# in /etc/default/grub:
GRUB_CMDLINE_LINUX_DEFAULT="loglevel=4 zswap.enabled=1"
# then run
sudo update-grub
```

# BTRFS compression

To compress everything with zstd 3rd level compression:
in /etc/fstab:

```bash
UUID=$uuid / btrfs defaults,compress=zstd:3 0 0
```
