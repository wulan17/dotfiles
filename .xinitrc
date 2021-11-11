picom --experimental-backends &
/usr/bin/pipewire &
/usr/bin/pipewire-pulse &
dbus-launch /usr/bin/pipewire-media-session &
exec dbus-run-session startlxqt
