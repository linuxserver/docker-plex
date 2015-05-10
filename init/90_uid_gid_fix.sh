#!/bin/bash

if [ ! "$(id -u plex)" -eq "$PUID" ]; then usermod -u "$PUID" plex ; fi
if [ ! "$(id -g plex)" -eq "$PGID" ]; then groupmod -g "$PGID" plex ; fi

echo "
-----------------------------------
PLEX GID/UID
-----------------------------------
Plex uid:    $(id -u plex)
Plex gid:    $(id -g plex)
-----------------------------------
Plex will now continue to boot.
"
sleep 2