FROM lsiobase/ubuntu:bionic

# set version label
ARG BUILD_DATE
ARG VERSION
ARG PLEX_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs, thelamer"

# global environment settings
ENV DEBIAN_FRONTEND="noninteractive" \
PLEX_DOWNLOAD="https://downloads.plex.tv/plex-media-server" \
PLEX_INSTALL="https://plex.tv/downloads/latest/1?channel=8&build=linux-ubuntu-x86_64&distro=ubuntu" \
PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR="/config/Library/Application Support" \
PLEX_MEDIA_SERVER_HOME="/usr/lib/plexmediaserver" \
PLEX_MEDIA_SERVER_INFO_DEVICE=docker \
PLEX_MEDIA_SERVER_MAX_PLUGIN_PROCS="6" \
PLEX_MEDIA_SERVER_USER=abc

RUN \
 echo "**** install runtime packages ****" && \
 apt-get update && \
 apt-get install -y \
	avahi-daemon \
	dbus \
	udev \
	unrar \
	wget \
  jq && \
 echo "**** Udevadm hack ****" && \
 mv /sbin/udevadm /sbin/udevadm.bak && \
 echo "exit 0" > /sbin/udevadm && \
 chmod +x /sbin/udevadm && \
 echo "**** install plex ****" && \
 if [ -z ${PLEX_RELEASE+x} ]; then \
 	PLEX_RELEASE=$(curl -sX GET https://artifacts.plex.tv/api/storage/plex-media-server-stable?lastModified \
	| jq -r '.| .uri' | awk -F '/' '{print $8}'); \
 fi && \
 curl -o \
	/tmp/plexmediaserver.deb -L \
	"https://artifacts.plex.tv/plex-media-server-stable/${PLEX_RELEASE}/debian/plexmediaserver_${PLEX_RELEASE}_amd64.deb" && \
 dpkg -i /tmp/plexmediaserver.deb && \
 mv /sbin/udevadm.bak /sbin/udevadm && \
 echo "**** ensure abc user's home folder is /app ****" && \
 usermod -d /app abc && \
 echo "**** cleanup ****" && \
 apt-get clean && \
 rm -rf \
	/etc/default/plexmediaserver \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

# add local files
COPY root/ /

#Add needed nvidia environment variables for https://github.com/NVIDIA/nvidia-docker
ENV NVIDIA_DRIVER_CAPABILITIES="compute,video,utility"

ENV NVIDIA_DRIVER_CAPABILITIES="all"

# ports and volumes
EXPOSE 32400 32400/udp 32469 32469/udp 5353/udp 1900/udp
VOLUME /config /transcode
