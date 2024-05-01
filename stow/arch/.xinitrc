#!/bin/bash

set -o nounset
set -o pipefail

# For some reason this is required to make special characters like @ work with
# xdotool, even though setxkbmap -verbose shows the same keymap anyway. See
# https://stackoverflow.com/a/36480692/27641.
setxkbmap gb

# Keyboard fixes; use xmodmap -pke to find current mappings
#
# FIXME: Do this only for the appropriate keyboard
# Correct inaccuracy on Durgod keyboard
# xmodmap -e "keycode 51 = asciitilde numbersign numbersign asciitilde dead_grave dead_breve dead_grave"

[[ -f ~/.Xresources ]] && xrdb -merge -I"${HOME}" ~/.Xresources

xset s 60 60
xscreensaver -no-splash &
xautolock -time 20 -locker "${HOME}/.local/bin/linux/suspend-if-no-ac" &

redshift -v | logger -t "${USER}-redshift" &
unclutter --ignore-scrolling --jitter 10 --fork
dunst &
variety -v | logger -t "${USER}-variety" &
bato &

# Automatically synchronize PRIMARY and CLIPBOARD
autocutsel -fork &
autocutsel -selection PRIMARY -fork &

# Turn off console beep
xset b off

# Turn off mute keyboard light
echo 0 > /sys/class/leds/platform::micmute/brightness

# Disable touchscreen/Trackpoint
xinput disable "Raydium Corporation Raydium Touch System"
xinput disable "TPPS/2 Elan TrackPoint"

rfkill block bluetooth
rfkill block wwan

export TERMCMD=kitty
export BROWSER=librewolf
export OPENER=$HOME/.local/bin/common-dotfiles/open-file

# https://wiki.archlinux.org/title/HiDPI#X_Resources

# Affects KeepassXC
export QT_AUTO_SCREEN_SCALE_FACTOR=0

exec i3
