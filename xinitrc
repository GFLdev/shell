#!/usr/bin/env sh

# monitors
xrandr \
  --output HDMI-A-0 \
  --mode 1920x1080 \
  --rate 60 \
  --primary \
  --output DVI-D-0 \
  --mode 1366x768 \
  --rate 60 \
  --left-of HDMI-A-0 \
  --rotate left

# wallpapers
$HOME/.config/feh/set_bg

# keyboard
setxkbmap us -variant intl

# audio
gentoo-pipewire-launcher &
pipewire-pulse &

# PATH
export PATH="$HOME/.local/bin:$PATH"

# Picom
killall -q picom
picom --daemon &

# dwm
exec dbus-launch --exit-with-session dwm
