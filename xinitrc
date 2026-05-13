#!/usr/bin/env sh

xrdb -merge ~/.Xresources
exec dbus-launch --exit-with-session dwm
