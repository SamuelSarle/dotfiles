#!/bin/sh

while true; do
	xsetroot -name "`apm | awk '!/absent/ && /[0-9]+%/ {print$4" |"}'` `awk '{print$0" |"}' /tmp/weather` `date "+%a %Y-%m-%d %H:%M:%S"`"
	sleep 1
done &

xset r rate 300 50
xset b off
setxkbmap -layout us
setxkbmap -option grp:alt_space_toggle us,ua,ru
xmodmap .xmodmaprc

xrdb .Xresources
xsetroot -solid '#444'
#feh --bg-scale ~/media/photos/wallpaper.jpg
while true; do
	dwm 2> ~/.dwm.log
done