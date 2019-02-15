if [ -x /home/samuel/bin/loginstartups ] ; then /bin/sh /home/samuel/bin/loginstartups ; fi

# Change Caps Lock to ESC (This is for console, for X use xmodmap)
/usr/sbin/kbdcontrol -l ~/.config/keysesccaps 2>/dev/null
/usr/sbin/kbdcontrol -r fast 2>/dev/null
