#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

 INSTALLED=`dpkg-query -W -f='${Version}' plexmediaserver`

if [[ "$PLEXPASS" ]]; then 
	echo "PLEXPASS is depricated, please use VERSION"
fi

if [[ -z $VERSION && "$PLEXPASS" == "1" || $VERSION = "plexpass" ]]; then
	VERSION=$(curl -s https://tools.linuxserver.io/latest-plexpass.json | grep "version" | cut -d '"' -f 4)
	echo "Useing version: $VERSION from Plexpass latest"
elif [[ $VERSION = "latest" || -z $VERSION ]]; then
	VERSION=$(curl -s https://tools.linuxserver.io/latest-plex.json| grep "version" | cut -d '"' -f 4)
	echo "Useing version: $VERSION from Public latest"
else
	echo "Useing version: $VERSION from Manual"
fi

last=130
if [[ ! "$VERSION" == "$INSTALLED "]]; then
	echo "Upgradeing from version: $INSTALLED to version: $VERSION"
	while [ last -ne "0"]; do
		rm -f /tmp/plexmediaserver_*.deb
		wget -P /tmp "http://downloads.plexapp.com/plex-media-server/$VERSION/plexmediaserver_${VERSION}_amd64.deb"
		last=$?
	done
else
	echo "Allready Uptodate"
fi

apt-get remove --purge -y plexmediaserver
gdebi -n /tmp/plexmediaserver_${VERSION}_amd64.deb




# INSTALLED=`dpkg-query -W -f='${Version}' plexmediaserver`
# if [ $VERSION ]; then 
# 	echo "Useing version: $VERSION from Manual"
# elif [ "$PLEXPASS" == "1" ]; then
# 	VERSION=$(curl -s https://tools.linuxserver.io/latest-plexpass.json | grep "version" | cut -d '"' -f 4)
# 	echo "Useing version: $VERSION from Plexpass latest"
# else
# 	VERSION=$(curl -s https://tools.linuxserver.io/latest-plex.json| grep "version" | cut -d '"' -f 4)
# 	echo "Useing version: $VERSION from Public latest"
# fi
# if [ "$VERSION" == "$INSTALLED" ]; then
# exit 0;
# fi
# mv /etc/default/plexmediaserver /tmp/
# apt-get remove --purge -y plexmediaserver
# wget -P /tmp "http://downloads.plexapp.com/plex-media-server/$VERSION/plexmediaserver_${VERSION}_amd64.deb"
# gdebi -n /tmp/plexmediaserver_${VERSION}_amd64.deb
# mv /tmp/plexmediaserver /etc/default/

