# Get Steam to work on Void
```bash
xbps-install -S void-repo-multilib{,-nonfree}
```
For mesa users this would result in:
```bash
xbps-install -S libgcc-32bit libstdc++-32bit libdrm-32bit libglvnd-32bit mesa-dri-32bit
```
# Add keyboard layouts
nvim /etc/rc.conf
