FROM lsiobase/xenial
MAINTAINER Stian Larsen, sparklyballs

# package version
ENV PLEX_URL="https://plex.tv/downloads"
ARG PLEX_WWW="${PLEX_URL}/latest/1?channel=8&build=linux-ubuntu-x86_64&distro=ubuntu"

# global environment settings
ENV DEBIAN_FRONTEND="noninteractive"
ENV HOME="/config"

# install packages
RUN \
 apt-get update && \
 apt-get install -y \
	avahi-daemon \
	dbus \
	wget && \

# install plex
 curl -o \
	/tmp/plexmediaserver.deb -L \
	"${PLEX_WWW}" && \
 dpkg -i /tmp/plexmediaserver.deb && \

# cleanup
 apt-get clean && \
 rm -rf \
	/etc/default/plexmediaserver \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 32400 32400/udp 32469 32469/udp 5353/udp 1900/udp
VOLUME /config /transcode
