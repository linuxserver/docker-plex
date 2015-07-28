#!/bin/bash

if [ -n "$PUID" -a "$(id -u abc)" != "$PUID" ]; then usermod -u "$PUID" abc ; fi
if [ -n "$PGID" -a "$(id -g abc)" != "$PGID" ]; then groupmod -o -g  "$PGID" abc ; fi

# There will be a lot of files in the config and searching through all of them will take a long time.
# Only Plex should modify these, so do a quick test to see if we need to search deeper.
if [ -n "$( find /config -maxdepth 2 -not \( -user abc -a -group abc \) )" ]; then
	find /config -not \( -user abc -a -group abc \) -exec chown abc:abc {} +
fi

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
