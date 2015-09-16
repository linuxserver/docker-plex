#!/bin/bash


if [ ! -d "/config/Library" ]; then
mkdir /config/Library
chown abc:abc /config/Library
fi



if [ ! -f "/config/Library/chown.log" ]; then
	chown -Rc abc:root /config/Library >> /config/Library/chown.log
fi