#!/bin/bash

if [ ! -d "/config/Library" ]; then
  mkdir /config/Library
  chown abc:abc /config/Library
fi

if [ ! -f "/config/Library/linuxserver-chown.lock" ]; then
  find /config/Library ! \( -user abc -a -group abc \) -print0 | xargs -0 chown abc:abc
  touch /config/Library/linuxserver-chown.lock
fi
