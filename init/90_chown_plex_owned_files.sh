#!/bin/bash

if [ ! -d "/config/Library" ]; then
  mkdir /config/Library
  chown abc:abc /config/Library
fi

if [ ! -f "/config/Library/linuxserver-chown.lock" ]; then
  find /config/Library ! \( -user abc -a -group root \) -print0 | xargs -0 chown abc:root
  touch /config/Library/linuxserver-chown.lock
fi
