FROM ghcr.io/linuxserver/baseimage-ubuntu:focal

# set version label
ARG BUILD_DATE
ARG VERSION
ARG PLEX_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="thelamer"

#Add needed nvidia environment variables for https://github.com/NVIDIA/nvidia-docker
ENV NVIDIA_DRIVER_CAPABILITIES="compute,video,utility"

# global environment settings
ENV DEBIAN_FRONTEND="noninteractive" \
PLEX_DOWNLOAD="https://downloads.plex.tv/plex-media-server-new" \
PLEX_ARCH="amd64" \
PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR="/config/Library/Application Support" \
PLEX_MEDIA_SERVER_HOME="/usr/lib/plexmediaserver" \
PLEX_MEDIA_SERVER_MAX_PLUGIN_PROCS="6" \
PLEX_MEDIA_SERVER_USER="abc" \
PLEX_MEDIA_SERVER_INFO_VENDOR="Docker" \
PLEX_MEDIA_SERVER_INFO_DEVICE="Docker Container (LinuxServer.io)"

RUN \
 echo "**** add Intel repo ****" && \
 curl -sL https://repositories.intel.com/graphics/intel-graphics.key | apt-key add - && \
 echo 'deb [arch=amd64] https://repositories.intel.com/graphics/ubuntu focal main' > /etc/apt/sources.list.d/intel.list && \
 echo "**** install runtime packages ****" && \
 apt-get update && \
 apt-get install -y \
	jq \
	intel-opencl-icd=21.49.21786+i643~u20.04 \
	udev \
	unrar \
	wget && \
 echo "**** install plex ****" && \
 if [ -z ${PLEX_RELEASE+x} ]; then \
 	PLEX_RELEASE=$(curl -sX GET 'https://plex.tv/api/downloads/5.json' \
	| jq -r '.computer.Linux.version'); \
 fi && \
 curl -o \
	/tmp/plexmediaserver.deb -L \
	"${PLEX_DOWNLOAD}/${PLEX_RELEASE}/debian/plexmediaserver_${PLEX_RELEASE}_${PLEX_ARCH}.deb" && \
 dpkg -i /tmp/plexmediaserver.deb && \
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
EXPOSE 32400/tcp 1900/udp 3005/tcp 5353/udp 8324/tcp 32410/udp 32412/udp 32413/udp 32414/udp 32469/tcp
VOLUME /config
