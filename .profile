if [ -x /home/samuel/bin/loginstartups ] ; then /bin/sh /home/samuel/bin/loginstartups ; fi

# Change Caps Lock to ESC (This is for console, for X use xmodmap)
/usr/sbin/kbdcontrol -l ~/Misc/keysesccaps 2>/dev/null

# Start SSH agent
eval `ssh-agent -s` >/dev/null
ssh-add >/dev/null
