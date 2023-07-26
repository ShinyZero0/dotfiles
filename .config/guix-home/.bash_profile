# .bash_profile

# Get the aliases and functions
[ -f $HOME/.bashrc ] && . $HOME/.bashrc
[ -f $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh ] && . $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh 

export PATH=$HOME/.guix-profile/bin:$HOME/.local/bin:$HOME/.dotnet/tools:$HOME/.cargo/bin:$PATH:$HOME/.dotnet
export XDG_DATA_DIRS=$XDG_DATA_DIRS:$HOME/.nix-profile/share:/usr/share

export DOTNET_CLI_TELEMETRY_OPTOUT=1
export POWERSHELL_TELEMETRY_OPTOUT=1
export LINKDING_TOKEN=28185e63c63f3324f5613ce152094b34731379a2
# export GTK_IM_MODULE=fcitx
# export XIM_PROGRAM=fcitx
# export XIM=fcitx
# export QT_IM_MODULE=fcitx
# export XMODIFIERS=@im=fcitx
# export GLFW_IM_MODULE=ibus
# export SDL_IM_MODULE=fcitx