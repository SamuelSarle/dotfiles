#!/bin/sh

while true; do
	xsetroot -name "`apm | awk '!/absent/ && /[0-9]+%/ {print$4" |"}'` `date "+%Y-%m-%d (%a) %H:%M:%S "`"
	sleep 1
done &

xset r rate 350 50
xset b off
setxkbmap -layout us
setxkbmap -option grp:alt_space_toggle us,ua

#caps lock as ctrl+esc
setxkbmap -option 'caps:ctrl_modifier'
xcape -e 'Caps_Lock=Escape'

#tab as windows key(mod4)+tab
xmodmap -e 'keycode 23 = Super_L'
xmodmap -e 'keycode any = Tab'
xcape -e 'Super_L=Tab'

xrdb .Xresources
xsetroot -solid '#444'
#feh --bg-scale ~/media/photos/wallpaper.jpg
while true; do
	dwm 2> ~/.dwm.log
done
