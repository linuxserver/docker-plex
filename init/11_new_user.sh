#!/bin/bash

if [ "$(id -u abc)" != "$PUID" ]; then usermod -o -u "$PUID" abc ; fi
if [ "$(id -g abc)" != "$PGID" ]; then groupmod -o -g  "$PGID" abc ; fi

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
