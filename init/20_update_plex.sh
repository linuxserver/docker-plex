#!/bin/bash

apt-get update -qq

[ "$PLEXPASS" ] && echo "PLEXPASS is deprecated, please use VERSION"

if [[ "$PLEXPASS" == "1" || "$VERSION" == "plexpass" ]]; then
  VERSION=$(curl -s https://tools.linuxserver.io/latest-plexpass.json | grep "version" | cut -d '"' -f 4)
  echo "using version $VERSION from plexpass latest"
elif [[ "$VERSION" = "latest" || -z $VERSION ]]; then
  VERSION=$(curl -s https://tools.linuxserver.io/latest-plex.json| grep "version" | cut -d '"' -f 4)
  echo "Using version $VERSION from public latest"
else
  echo "Using version $VERSION from manual"
fi

# shellcheck disable=SC2016
INSTALLED=$(dpkg-query -W -f='${Version}' plexmediaserver)

if [ "$VERSION" != "$INSTALLED" ]; then
  echo "upgrading from version $INSTALLED to version $VERSION"
  wget -t 12 -w 5 --retry-connrefused -P /tmp "https://downloads.plexapp.com/plex-media-server/$VERSION/plexmediaserver_${VERSION}_amd64.deb"
  if [ $? -eq 0 ]; then
    apt-get remove --purge -y plexmediaserver
    gdebi -n "/tmp/plexmediaserver_${VERSION}_amd64.deb"
    apt-get clean
    rm -f "/tmp/plexmediaserver_${VERSION}_amd64.deb"
  else
    echo "failed to download version $VERSION"
    echo "continuing with version $INSTALLED"
  fi
else
  echo "plex is already the newest version"
fi

cp -v /defaults/plexmediaserver /etc/default/plexmediaserver
