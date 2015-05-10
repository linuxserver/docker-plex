#!/bin/bash

if [ -e /var/run/dbus/pid ]; then rm -f /var/run/dbus/pid; fi
mkdir -p /var/run/dbus
chown messagebus:messagebus /var/run/dbus
dbus-uuidgen --ensure
sleep 1
