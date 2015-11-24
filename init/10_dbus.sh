#!/bin/bash

[[ -e /var/run/dbus/pid ]] && rm -f /var/run/dbus/pid

mkdir -p /var/run/dbus
chown messagebus:messagebus /var/run/dbus
dbus-uuidgen --ensure
sleep 1
