#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
INSTALLED=`dpkg-query -W -f='${Version}' plexmediaserver`
if [ -z "$PLEXPASS" ]; then
	VERSION=$(curl https://lonix.me/mirror/plex/plexPub.ver)
else
	VERSION=$(curl https://lonix.me/mirror/plex/plexPass.ver)
fi
if [ "$VERSION" == "$INSTALLED" ]; then
exit 0;
fi
mv /etc/default/plexmediaserver /tmp/
apt-get remove --purge -y plexmediaserver
wget -P /tmp "http://downloads.plexapp.com/plex-media-server/$VERSION/plexmediaserver_${VERSION}_amd64.deb"
gdebi -n /tmp/plexmediaserver_${VERSION}_amd64.deb
mv /tmp/plexmediaserver /etc/default/
