FROM linuxserver/baseimage
MAINTAINER Stian Larsen <lonixx@gmail.com>

RUN apt-get -q update && \
apt-get install -qy dbus gdebi-core avahi-daemon wget && \
VERSION=$(curl -s https://tools.linuxserver.io/latest-plex.json| grep "version" | cut -d '"' -f 4) && \
wget -t 12 -w 5 --retry-connrefused -P /tmp "https://downloads.plexapp.com/plex-media-server/$VERSION/plexmediaserver_${VERSION}_amd64.deb" && \
gdebi -n "/tmp/plexmediaserver_${VERSION}_amd64.deb" && \
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD init/ /etc/my_init.d/
ADD services/ /etc/service/
RUN chmod -v +x /etc/service/*/run
RUN chmod -v +x /etc/my_init.d/*.sh

ADD plexmediaserver /defaults/plexmediaserver

VOLUME /config
EXPOSE 32400
