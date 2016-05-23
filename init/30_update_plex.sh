#!/bin/bash

# opt out for autoupdates
[ "$ADVANCED_DISABLEUPDATES" ] && exit 0

export DEBIAN_FRONTEND=noninteractive

while ! ping -c1 tools.linuxserver.io &>/dev/null; do :; done

#The following error is not an error.
INSTALLED=$(dpkg-query -W -f='${Version}' plexmediaserver)


#Get stuff from things.
PLEX_TOKEN=$( sed -n 's/.*PlexOnlineToken="//p' "/config/Library/Application Support/Plex Media Server/Preferences.xml" | sed "s/\".*//")
[ -z "$PLEX_TOKEN" ] && echo "Plex token not avalible, please login " && exit 0

[ "$PLEXPASS" ] && echo "PLEXPASS is deprecated, please use VERSION"
if [[ -z $VERSION && "$PLEXPASS" == "1" || $VERSION = "plexpass" ]]; then echo "VERSION=plexpass is depricated please use version latest"; fi


#Start update rutine


if [[ "$VERSION" = latest || "$VERSION" = plexpass ]]; then
	VERSION=$(curl -s "https://plex.tv/downloads/latest/1?channel=8&build=linux-ubuntu-x86_64&distro=ubuntu&X-Plex-Token=$PLEX_TOKEN"| cut -d "/" -f 5 )
	echo "Target version: $VERSION set by: latest\plexpass"
elif [[ "$VERSION" = public ]]; then
	VERSION=$(curl -s "https://plex.tv/downloads/latest/1?channel=8&build=linux-ubuntu-x86_64&distro=ubuntu&X-Plex-Token="| cut -d "/" -f 5 )
	echo "Target version: $VERSION set by: public"
elif [[ -z "$VERSION" ]]; then
	echo "Target version: Version not set, Defaulting to supplied version"
else
	echo "Target version: $VERSION set by: manually"
fi




last=130
if [[ "$VERSION" == "" ]]; then
  echo "ERROR: No version found, running installed version $INSTALLED"
elif [[ "$VERSION" != "$INSTALLED" ]]; then
  echo "Upgrading from version: $INSTALLED to version: $VERSION"
    while [[ $last -ne "0" ]]; do
	  rm -f /tmp/plexmediaserver_*.deb
	  wget -P /tmp "https://downloads.plex.tv/plex-media-server/$VERSION/plexmediaserver_${VERSION}_amd64.deb"
	  last=$?
	done
	apt-get remove --purge -y plexmediaserver
	dpkg -i /tmp/plexmediaserver_"${VERSION}"_amd64.deb
else
	echo "No need to update!"
fi
cp -v /defaults/plexmediaserver /etc/default/plexmediaserver
