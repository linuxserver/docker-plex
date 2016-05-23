FROM linuxserver/baseimage
MAINTAINER Stian Larsen <lonixx@gmail.com>

#Copy Our files into filesystem.
COPY ROOT /

# Install Plex
RUN apt-get -q update && \
apt-get install -qy dbus avahi-daemon wget && \
curl -L 'https://plex.tv/downloads/latest/1?channel=8&build=linux-ubuntu-x86_64&distro=ubuntu' -o /tmp/plexmediaserver.deb && \
dpkg -i /tmp/plexmediaserver.deb && rm -f /tmp/plexmediaserver.deb && \
apt-get clean && \
chmod -v +x /etc/service/*/run /etc/my_init.d/*.sh && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Mappings and ports
VOLUME ["/config"]

#This image is designed to run with --net=host, ports listed for probablilty
EXPOSE 32400 32400/udp 32469 32469/udp 5353/udp 1900/udp
