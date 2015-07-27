#!/bin/bash

if [ "$(id -u abc)" != "$PUID" ]; then usermod -u "$PUID" abc ; fi
if [ "$(id -g abc)" != "$PGID" ]; then groupmod -o -g  "$PGID" abc ; fi
find /config -not \( -user abc -a -group abc \) -exec chown abc:abc {} +
# May not be a good idea to mess with permissions set by Plex
#find /config -type f -a -perm -0660 -exec chmod ug+rw {} +
#find /config -type d -a -perm -0770 -exec chmod ug+rwx {} +

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
