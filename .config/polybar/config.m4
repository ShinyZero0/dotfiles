;==========================================================
;
;
;   ██████╗  ██████╗ ██╗  ██╗   ██╗██████╗  █████╗ ██████╗
;   ██╔══██╗██╔═══██╗██║  ╚██╗ ██╔╝██╔══██╗██╔══██╗██╔══██╗
;   ██████╔╝██║   ██║██║   ╚████╔╝ ██████╔╝███████║██████╔╝
;   ██╔═══╝ ██║   ██║██║    ╚██╔╝  ██╔══██╗██╔══██║██╔══██╗
;   ██║     ╚██████╔╝███████╗██║   ██████╔╝██║  ██║██║  ██║
;   ╚═╝      ╚═════╝ ╚══════╝╚═╝   ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
;
;
;   To learn more about how to configure Polybar
;   go to https://github.com/polybar/polybar
;
;   The README contains a lot of information
;
;==========================================================

[colors]

background     = ${xrdb:background}
background-alt = ${xrdb:color0}
foreground     = ${self.white}
primary        = ${xrdb:color6}
secondary      = ${xrdb:color14}

alert       = ${xrdb:color9}
success     = ${xrdb:color2}
disabled    = ${xrdb:color8}
urgent      = ${xrdb:color5}
transparent = #00000000
white       = #FFFFFF

modback-2 = ${self.background}
modback-1 = ${self.disabled}

[bar/upperbar]

modules-left   = leftest bspwm left1
modules-right  = player right2 right1 xkeyboard right2 pulseaudio right1 memory right2 cpu right1 online
modules-center = date

# FONTS

# Display font
font-0 = InconsolataLGC Nerd Font Mono: style=Bold: size=12: antialias=true; 2

# icons fonts:
font-1 = flags color world: style=Regular: size=20; 4
font-2 = InconsolataLGC Nerd Font Mono: style=Bold: size=24; 6
font-3 = Font Awesome 6 Free: style=Solid: size=16; 3

# angles font:
font-4 = InconsolataLGC Nerd Font Mono: style=Bold: size=24; 7 

# angles separator for i3 module font:
font-5 = InconsolataLGC Nerd Font Mono: style=Bold: size=40; 12 

define(`gaps', `10')
# gaps
offset-y = gaps()px
offset-x = gaps()px

changequote(`[', `]')dnl
width = eval(esyscmd([xrandr -q | awk '$2 ~ "+" {print $1}' | cut -d x -f 1])-gaps()*2)px
changequote()dnl
height = 26pt
radius = 0

background = ${colors.background}
foreground = ${colors.foreground}

padding-left = 0
padding-right = 0
module-margin = 0

cursor-click = pointer
cursor-scroll = ns-resize

enable-ipc = true

tray-position = none
wm-restack = bspwm

[module/bspwm]

type = internal/bspwm

reverse-scroll = true

label-active = %name%
label-active-padding = 1
label-active-foreground = ${colors.secondary}
label-active-background = ${colors.disabled}

label-occupied = %name%
label-occupied-padding = 1
label-occupied-background = ${colors.disabled}

label-empty = ""

label-urgent = %name%
label-urgent-padding = 1
label-urgent-foreground= ${colors.urgent}
label-urgent-background = ${colors.disabled}

[module/pulseaudio]

type = internal/pulseaudio
use-ui-max = true
format-volume-prefix = " %{T3}󰕾%{T-} "
format-volume-prefix-foreground = ${colors.primary}
format-volume-prefix-background = ${colors.modback-1}
format-volume = <label-volume>

label-volume = "%percentage%% "
label-volume-background = ${colors.modback-1}

label-muted = " %{T3}󰖁%{T-}  0% "
label-muted-foreground = ${colors.alert}
label-muted-background = ${colors.modback-1}

[module/xkeyboard]

type = internal/xkeyboard
blacklist-0 = num lock

label-layout = " %icon% "
label-layout-font = 2
label-layout-background = ${colors.modback-2}
layout-icon-0 = us;u
layout-icon-1 = ru;r
label-indicator-on-capslock = "%{B#1e1c31}%{F#ff5458}Caps Lock!"

[module/memory]

type = internal/memory
interval = 2
format-prefix = " %{T4}%{T-} "
format-prefix-foreground = ${colors.primary}
format-prefix-background = ${colors.modback-2}
label = "%percentage_used:2%% "
label-background = ${colors.modback-2}

[module/cpu]

type = internal/cpu
interval = 2
format-prefix = " %{T4}%{T-} "
format-prefix-foreground = ${colors.primary}
format-prefix-background = ${colors.modback-1}
label = "%percentage:2%% "
label-background = ${colors.modback-1}

[module/date]

type = internal/date
interval = 1

date = "%{F#aaffe4}%Y.%m.%d %{F#ffe9aa}%H:%M:%S"
label = %date%
label-foreground = ${colors.foreground}

[glyph]

gleft = 
gright = 

[module/right1]

type = custom/text
content-background = ${colors.modback-1}
content-foreground = ${colors.modback-2}
content = ${glyph.gright}
content-font = 5

[module/right2]

type = custom/text
content-background = ${colors.modback-2}
content-foreground = ${colors.modback-1}
content = ${glyph.gright}
content-font = 5

[module/right11]

type = custom/text
content-background = ${colors.background}
content-foreground = ${colors.modback-2}
content = ${glyph.gright}
content-font = 5

[module/left1]

type = custom/text
content-background = ${colors.background}
content-foreground = ${colors.disabled}
content = ${glyph.gleft}
content-font = 5

[module/leftest]

type = custom/text
content-background = ${colors.disabled}
content-foreground = ${colors.background}
content = " "
content-font = 4

; check network connection
[module/online]

type = custom/script

exec = ~/.scripts/PolybarOnline.sh
tail = true
label = " %{T3}%output%%{T-}  "
label-foreground = ${colors.primary}
label-background = ${colors.modback-2}

[module/player]

type = custom/script
exec = ~/.scripts/PolybarPlayer
tail = true
label = "%{T1}%output%%{T-} "
label-padding = 0
