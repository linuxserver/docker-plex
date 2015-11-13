FROM linuxserver/baseimage
MAINTAINER Stian Larsen <lonixx@gmail.com>

# Install Plex
RUN apt-get -q update && \
VERSION=$(curl -s https://tools.linuxserver.io/latest-plex.json| grep "version" | cut -d '"' -f 4) && \
apt-get install -qy dbus gdebi-core avahi-daemon wget && \
wget -P /tmp "https://downloads.plex.tv/plex-media-server/$VERSION/plexmediaserver_${VERSION}_amd64.deb" && \
gdebi -n /tmp/plexmediaserver_${VERSION}_amd64.deb && \
rm -f /tmp/plexmediaserver_${VERSION}_amd64.deb && \
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


#Adding Custom files
ADD init/ /etc/my_init.d/
ADD services/ /etc/service/
RUN chmod -v +x /etc/service/*/run
RUN chmod -v +x /etc/my_init.d/*.sh
# Define /config in the configuration file not using environment variables
ADD plexmediaserver /defaults/plexmediaserver

#Mappings and ports
VOLUME ["/config", "/transcode"]
EXPOSE 32400