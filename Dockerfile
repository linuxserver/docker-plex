FROM linuxserver/baseimage
MAINTAINER Stian Larsen <lonixx@gmail.com>

# Install Plex
RUN apt-get -q update && \
PLEXURL=$(curl -s https://tools.linuxserver.io/latest-plex.json| grep "ubuntu64" | cut -d '"' -f 4) && \
apt-get install -qy dbus gdebi-core avahi-daemon wget && \
wget -P /tmp "$PLEXURL" && \
gdebi -n /tmp/plexmediaserver_*_amd64.deb && \
rm -f /tmp/plexmediaserver_*_amd64.deb && \
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


#Adding Custom files
COPY init/ /etc/my_init.d/
COPY services/ /etc/service/
RUN chmod -v +x /etc/service/*/run /etc/my_init.d/*.sh

# Define /config in the configuration file not using environment variables
ADD plexmediaserver /defaults/plexmediaserver

#Mappings and ports
VOLUME ["/config", "/transcode"]
EXPOSE 32400
