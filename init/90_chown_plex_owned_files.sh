#!/bin/bash

[ ! -d "/config/Library" ] && mkdir /config/Library
[ ! -d "/transcode" ] && mkdir /transcode && chown abc:abc /transcode

# this is to allow users to import an existing plex install
if [ ! -f "/config/Library/linuxserverio-chown.lock" ]; then
  find /config/Library ! \( -user abc -a -group abc \) -print0 | xargs -0 chown abc:abc
  touch /config/Library/linuxserverio-chown.lock
fi
