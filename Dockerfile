FROM phusion/baseimage:0.9.16
MAINTAINER Stian Larsen <lonixx@gmail.com>
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root


# Use baseimage-docker's init system
CMD ["/sbin/my_init"]


# Install Plex
RUN apt-get -q update && \
apt-get install -qy gdebi-core wget && \
wget -P /tmp http://downloads.plexapp.com/plex-media-server/0.9.9.14.531-7eef8c6/plexmediaserver_0.9.9.14.531-7eef8c6_amd64.deb && \
gdebi -n /tmp/plexmediaserver_0.9.9.14.531-7eef8c6_amd64.deb && \
rm -f /tmp/plexmediaserver_0.9.9.14.531-7eef8c6_amd64.deb && \
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Mappings and ports
VOLUME /config
EXPOSE 32400


# Define /config in the configuration file not using environment variables
ADD plexmediaserver /etc/default/plexmediaserver

#Adding Custom files
ADD init/ /etc/my_init.d/
ADD services/ /etc/service/
RUN chmod -v +x /etc/service/*/run
RUN chmod -v +x /etc/my_init.d/*.sh
