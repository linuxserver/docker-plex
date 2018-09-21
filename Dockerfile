FROM lsiobase/ubuntu:bionic

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs"

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
 echo "$TZ > /etc/timezone" && \
 apt-get update && \
 apt-get install -y \
        avahi-daemon \
        dbus \
        udev \
        unrar \
        tzdata \
        wget && \
 rm /etc/localtime && \
 ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
 echo "**** install plex ****" && \
 curl -o \
 /tmp/plexmediaserver.deb -L \
        "${PLEX_INSTALL}" && \
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
EXPOSE 32400 32400/udp 32469 32469/udp 5353/udp 1900/udp
VOLUME /config /transcode
