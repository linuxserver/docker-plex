#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
INSTALLED=`dpkg-query -W -f='${Version}' plexmediaserver`
if [ $VERSION ]; then 
	echo "Useing version: $VERSION from Manual"
elif [ "$PLEXPASS" == "1" ]; then
	VERSION=$(curl -s https://fanart.tv/webservice/plex/plex.php?v=plexpass | grep "version" | cut -d '"' -f 4)
	echo "Useing version: $VERSION from Plexpass latest"
else
	VERSION=$(curl -s https://fanart.tv/webservice/plex/plex.php | grep "version" | cut -d '"' -f 4)
	echo "Useing version: $VERSION from Public latest"
fi
if [ "$VERSION" == "$INSTALLED" ]; then
exit 0;
fi
mv /etc/default/plexmediaserver /tmp/
apt-get remove --purge -y plexmediaserver
wget -P /tmp "http://downloads.plexapp.com/plex-media-server/$VERSION/plexmediaserver_${VERSION}_amd64.deb"
gdebi -n /tmp/plexmediaserver_${VERSION}_amd64.deb
mv /tmp/plexmediaserver /etc/default/
