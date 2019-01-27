while xsetroot -name "`apm | grep "[0-9][0-9]%" | awk 'NR==1{print$4}'`   `date "+%a %Y-%m-%d %H:%M:%S"`"
  do
  sleep 1
done &
xset r rate 300 50
xset b off
xrdb .Xresources
xmodmap ~/.xmodmaprc
feh --bg-scale ~/Media/photos/wallpaper.jpg
exec dwm
