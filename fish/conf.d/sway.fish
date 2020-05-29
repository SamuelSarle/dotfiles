. ~/.config/fish/config.fish

#if running from tty start sway
set TTY1 (tty)
if test -z "$DISPLAY"; and test $TTY1 = "/dev/tty1"
	exec sway
	echo "$PATH" > /tmp/debug.out
end
