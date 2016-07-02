FROM lsiobase/xenial
MAINTAINER Stian Larsen, sparklyballs

# global environment settings
ENV DEBIAN_FRONTEND="noninteractive"
ENV HOME="/config"

# install packages
RUN \
 apt-get update && \
 apt-get install -y \
	avahi-daemon \
	dbus \
	less \
	wget && \
# cleanup
 apt-get clean && \
 rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

# install plex
RUN \
 curl -o \
	/tmp/plexmediaserver.deb -L \
	'https://plex.tv/downloads/latest/1?channel=8&build=linux-ubuntu-x86_64&distro=ubuntu' && \
 dpkg -i /tmp/plexmediaserver.deb && \
	rm -f /tmp/plexmediaserver.deb

# add local files
COPY root/ /

# ports and volumes
VOLUME /config
EXPOSE 32400 32400/udp 32469 32469/udp 5353/udp 1900/udp
