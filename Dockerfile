FROM linuxserver/baseimage
MAINTAINER Stian Larsen <lonixx@gmail.com>

# Install Plex
RUN apt-get -q update && \
apt-get install -qy dbus avahi-daemon wget && \
curl -L 'https://plex.tv/downloads/latest/1?channel=8&build=linux-ubuntu-x86_64&distro=ubuntu' -o /tmp/plexmediaserver.deb && \
dpkg -i /tmp/plexmediaserver.deb && rm -f /tmp/plexmediaserver.deb && \
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


#Adding Custom files
COPY init/ /etc/my_init.d/
COPY services/ /etc/service/
RUN chmod -v +x /etc/service/*/run /etc/my_init.d/*.sh

# Define /config in the configuration file not using environment variables
COPY plexmediaserver /defaults/plexmediaserver

#Mappings and ports
VOLUME ["/config"]
EXPOSE 32400 32400/udp 32469 32469/udp 5353/udp 1900/udp
