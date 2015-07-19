#!/bin/bash


if [ -d "/config/Library" ]; then
find "/config/Library" \! -user abc -exec chown -hv abc:abc {} \;
find "/config/Library" \! -group abc -exec chown -hv abc:abc {} \;
find "/config/Library/Application Support/Plex Media Server/Plug-ins" 
fi

