# How to make shit work

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
With fcitx, but that doesn't work in some programs e.g. games
```bash
xbps-install fcitx5
```
