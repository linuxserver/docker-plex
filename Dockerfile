FROM lsiobase/ubuntu:bionic

# set version label
ARG BUILD_DATE
ARG VERSION
ARG PLEX_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs, thelamer"

#Add needed nvidia environment variables for https://github.com/NVIDIA/nvidia-docker
ENV NVIDIA_DRIVER_CAPABILITIES="compute,video,utility"

# global environment settings
ENV DEBIAN_FRONTEND="noninteractive" \
PLEX_DOWNLOAD="https://downloads.plex.tv/plex-media-server" \
PLEX_INSTALL="https://plex.tv/downloads/latest/1?channel=8&build=linux-ubuntu-x86_64&distro=ubuntu" \
PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR="/config/Library/Application Support" \
PLEX_MEDIA_SERVER_HOME="/usr/lib/plexmediaserver" \
PLEX_MEDIA_SERVER_MAX_PLUGIN_PROCS="6" \
PLEX_MEDIA_SERVER_USER="abc" \
PLEX_MEDIA_SERVER_INFO_VENDOR="Docker" \
PLEX_MEDIA_SERVER_INFO_DEVICE="Docker Container (LinuxServer.io)"

RUN \
 echo "**** install runtime packages ****" && \
 apt-get update && \
 apt-get install -y \
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
 	PLEX_RELEASE=$(curl -s 'https://plex.tv/downloads/details/1?build=linux-ubuntu-x86_64&distro=ubuntu' \
	|grep -oP 'version="\K[^"]+' | tail -n 1); \
 fi && \
 curl -o \
	/tmp/plexmediaserver.deb -L \
	"https://downloads.plex.tv/plex-media-server/${PLEX_RELEASE}/plexmediaserver_${PLEX_RELEASE}_amd64.deb" && \
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

# ports and volumes
EXPOSE 32400 32400/udp 32469 32469/udp 5353/udp 1900/udp
VOLUME /config /transcode
