#!/bin/bash


if [ -d "/config/Library" ]; then
find "/config/Library" \! -user abc -exec chown -h abc:abc {} \;
find "/config/Library" \! -group abc -exec chown -h abc:abc {} \;
chmod -R ug+w "/config/Library"
fi
