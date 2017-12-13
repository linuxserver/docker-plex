[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/irc/
[podcasturl]: https://www.linuxserver.io/podcast/
[appurl]: https://plex.tv
[hub]: https://hub.docker.com/r/linuxserver/plex/

[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)][linuxserverurl]

The [LinuxServer.io][linuxserverurl] team brings you another container release featuring easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io][forumurl]
* [IRC][ircurl] on freenode at `#linuxserver.io`
* [Podcast][podcasturl] covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

# linuxserver/plex
[![](https://images.microbadger.com/badges/version/linuxserver/plex.svg)](https://microbadger.com/images/linuxserver/plex "Get your own version badge on microbadger.com")[![](https://images.microbadger.com/badges/image/linuxserver/plex.svg)](https://microbadger.com/images/linuxserver/plex "Get your own image badge on microbadger.com")[![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/plex.svg)][hub][![Docker Stars](https://img.shields.io/docker/stars/linuxserver/plex.svg)][hub][![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Builders/x86-64/x86-64-plex)](https://ci.linuxserver.io/job/Docker-Builders/job/x86-64/job/x86-64-plex/)

[Plex](https://plex.tv/) organizes video, music and photos from personal media libraries and streams them to smart TVs, streaming boxes and mobile devices. This container is packaged as a standalone Plex Media Server.

[![plex](http://the-gadgeteer.com/wp-content/uploads/2015/10/plex-logo-e1446990678679.png)][appurl]

## Usage

```
docker create \
--name=plex \
--net=host \
-e VERSION=latest \
-e PUID=<UID> -e PGID=<GID> \
-e TZ=<timezone> \
-v </path/to/library>:/config \
-v <path/to/tvseries>:/data/tvshows \
-v </path/to/movies>:/data/movies \
-v </path for transcoding>:/transcode \
linuxserver/plex
```

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`


* `--net=host` - Shares host networking with container, **required**.
* `-v /config` - Plex library location. *This can grow very large, 50gb+ is likely for a large collection.*
* `-v /data/xyz` - Media goes here. Add as many as needed e.g. `/data/movies`, `/data/tv`, etc.
* `-v /transcode` - Path for transcoding folder, *optional*.
* `-e VERSION=latest` - Set whether to update plex or not - see Setting up application section.
* `-e PGID=` for for GroupID - see below for explanation
* `-e PUID=` for for UserID - see below for explanation
* `-e TZ` - for timezone information *eg Europe/London, etc*

It is based on ubuntu xenial with s6 overlay, for shell access whilst the container is running do `docker exec -it plex /bin/bash`.

*Special note* - If you'd like to run Plex without requiring `--net=host` (`NOT recommended`) then you will need the following ports in your `docker create` command:

```
  -p 32400:32400 \
  -p 32400:32400/udp \
  -p 32469:32469 \
  -p 32469:32469/udp \
  -p 5353:5353/udp \
  -p 1900:1900/udp
```

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" <sup>TM</sup>.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application
Webui can be found at `<your-ip>:32400/web`

** Note about updates, if there is no value set for the VERSION variable, then no updates will take place.**

** For new users, no updates will take place on the first run of the container as there is no preferences file to read your token from, to update restart the Docker container after logging in through the webui**

Valid settings for VERSION are:-

`IMPORTANT NOTE:- YOU CANNOT UPDATE TO A PLEXPASS ONLY VERSION IF YOU DO NOT HAVE PLEXPASS`

+ **`latest`**: will update plex to the latest version available that you are entitled to.
+ **`public`**: will update plexpass users to the latest public version, useful for plexpass users that don't want to be on the bleeding edge but still want the latest public updates.
+ **`<specific-version>`**: will select a specific version (eg 0.9.12.4.1192-9a47d21) of plex to install, note you cannot use this to access plexpass versions if you do not have plexpass.

## Info

* Shell access whilst the container is running: `docker exec -it plex /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f plex`

To upgrade to the latest version (see setting up application section) : `docker restart plex`

* container version number 

`docker inspect -f '{{ index .Config.Labels "build_version" }}' plex`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/plex`

## Versions

+ **09.12.17:** Fix continuation lines.
+ **12.07.17:** Add inspect commands to README, move to jenkins build and push.
+ **28.05.17:** Add unrar package as per requests, for subzero plugin.
+ **11.01.17:** Use Plex environemt variables from pms docker,
change abc home folder to /app to alleviate usermod chowning library folder by default (thanks gbooker, plexinc).
+ **03.01.17:** Use case insensitive version variable matching rather than export and make lowercase.
+ **17.10.16:** Allow use of uppercase version variable
+ **01.10.16:** Add TZ info to README.
+ **09.09.16:** Add layer badges to README.
+ **27.08.16:** Add badges to README.
+ **22.08.16:** Rebased to xenial and s6 overlay
+ **07.04.16:** removed `/transcode` volume support (upstream Plex change) and modified PlexPass download method to prevent unauthorised usage of paid PMS
+ **24.09.15:** added optional support for volume transcoding (/transcode), and various typo fixes.
+ **17.09.15:** Changed to run chmod only once
+ **19.09.15:** Plex updated their download servers from http to https
+ **28.08.15:** Removed plexpass from routine, and now uses VERSION as a combination fix.
+ **18.07.15:** Moved autoupdate to be hosted by linuxserver.io and implemented bugfix thanks to ljm42.
+ **09.07.15:** Now with ability to pick static version number.
+ **08.07.15:** Now with autoupdates. (Hosted by fanart.tv)
+ **03.07.15:** Fixed a mistake that allowed plex to run as user plex rather than abc (99:100). Thanks to double16 for spotting this.
