#!/bin/bash


if [ -d "/config/Library/Application Support" ]; then
find "/config/Library/Application Support" \! -user abc -exec chown -h abc:abc {} \;
find "/config/Library/Application Support" \! -group abc -exec chown -h abc:abc {} \;
fi
