#!/bin/bash


if [ -d "/config/Library" ]; then
find /config/Library ! \( -user abc -a -group abc \) -exec chown -hv abc:abc {} +
else
mkdir /config/Library
chown abc:abc /config/Library
fi

