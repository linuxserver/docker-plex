#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
INSTALLED=`dpkg-query -W -f='${Version}' plexmediaserver`
if [ "$PLEXPASS" == "1" ]; then
	VERSION=$(curl https://raw.githubusercontent.com/linuxserver/misc-files/master/plex-version/plexpass)
else
	VERSION=$(curl https://raw.githubusercontent.com/linuxserver/misc-files/master/plex-version/public)
fi
if [ "$VERSION" == "$INSTALLED" ]; then
exit 0;
fi
mv /etc/default/plexmediaserver /tmp/
apt-get remove --purge -y plexmediaserver
wget -P /tmp "http://downloads.plexapp.com/plex-media-server/$VERSION/plexmediaserver_${VERSION}_amd64.deb"
gdebi -n /tmp/plexmediaserver_${VERSION}_amd64.deb
mv /tmp/plexmediaserver /etc/default/
