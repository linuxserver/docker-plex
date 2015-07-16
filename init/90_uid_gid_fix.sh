#!/bin/bash

if [ "$(id -u abc)" != "$PUID" ]; then usermod -u "$PUID" abc ; fi
if [ "$(id -g abc)" != "$PGID" ]; then groupmod -o -g  "$PGID" abc ; fi
chown -R abc:abc /config
chmod ug+rw /config
find /config -type d -print0 | xargs -0 chmod ug+rwx

echo "
-----------------------------------
Plex GID/UID
-----------------------------------
Plex uid:    $(id -u abc)
Plex gid:    $(id -g abc)
-----------------------------------
Plex will now continue to boot.
"
sleep 2
