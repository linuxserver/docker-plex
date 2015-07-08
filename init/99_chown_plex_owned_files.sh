#!/bin/bash


if [ -f /config/Library/Application Support]; then
find "/config/Library/Application Support" -user plex -exec chown abc:abc {} \;
fi