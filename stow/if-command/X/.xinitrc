#!/bin/bash

set -o nounset
set -o pipefail

# For some reason this is required to make special characters like @ work with
# xdotool, even though setxkbmap -verbose shows the same keymap anyway. See
# https://stackoverflow.com/a/36480692/27641.
setxkbmap gb

[[ -f ~/.Xresources ]] && xrdb -merge -I"${HOME}" ~/.Xresources

xscreensaver -no-splash &
xautolock -time 20 -locker "${HOME}/.local/bin/linux/suspend-if-no-ac" &

redshift -v | logger -t "${USER}-redshift" &
unclutter --ignore-scrolling --jitter 10 --fork
picom --daemon
dunst &
${HOME}/.local/bin/linux/screensize-change

# Automatically synchronize PRIMARY and CLIPBOARD
autocutsel -fork &
autocutsel -selection PRIMARY -fork &

# Turn off console beep
xset b off

# Speed up keyboard a little
xset r rate 250 60

# Disable touchscreen/Trackpoint
xinput disable "Raydium Corporation Raydium Touch System"
xinput disable "TPPS/2 Elan TrackPoint"

amixer set Master 0
amixer set Master unmute
amixer set Speaker unmute
amixer set Headphone unmute

amixer set Capture 0

rfkill block bluetooth
rfkill block wwan

export TERMCMD=kitty
export BROWSER=qutebrowser

# https://wiki.archlinux.org/title/HiDPI#X_Resources

# Affects qutebrowser, KeepassXC
export QT_AUTO_SCREEN_SCALE_FACTOR=0

exec i3
