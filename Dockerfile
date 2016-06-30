FROM ubuntu:16.04
MAINTAINER Stian Larsen, sparklyballs

# global environment settings
ENV DEBIAN_FRONTEND="noninteractive"
ENV HOME="/config"
ENV TERM="xterm"

# add abc user and make folders
RUN \
 useradd -u 911 -U -d /config -s /bin/false abc && \
 usermod -G users abc && \
 mkdir -p \
	/config

# install packages
RUN \
 apt-get update && \
 apt-get install -y \
	apt-utils && \
 apt-get install -y \
	avahi-daemon \
	curl \
	dbus \
	wget && \

# add s6 overlay
 curl -o \
	/tmp/s6.tar.gz -L \
	https://github.com/just-containers/s6-overlay/releases/download/v1.17.2.0/s6-overlay-amd64.tar.gz && \
 tar xvf /tmp/s6.tar.gz -C / && \

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


ENTRYPOINT ["/init"]

# add local files
COPY root/ /

# ports and volumes
VOLUME /config
EXPOSE 32400 32400/udp 32469 32469/udp 5353/udp 1900/udp
