![https://linuxserver.io](https://www.linuxserver.io/wp-content/uploads/2015/06/linuxserver_medium.png)

The [LinuxServer.io](https://linuxserver.io) team brings you another container release featuring auto-update on startup, easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io](https://forum.linuxserver.io)
* [IRC](https://www.linuxserver.io/index.php/irc/) on freenode at `#linuxserver.io`
* [Podcast](https://www.linuxserver.io/index.php/category/podcast/) covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

# linuxserver/plex

[Plex](https://plex.tv/) organizes video, music and photos from personal media libraries and streams them to smart TVs, streaming boxes and mobile devices. This container is packaged as a standalone Plex Media Server.

![](https://press.plex.tv/wp-content/themes/plex-press/img/assets/plex-pms-icon.png)

## Usage

```
docker create \
	--name=plex \
	--net=host \
	-e VERSION=plexpass \
	-e PUID=<UID> -e PGID=<GID> \
	-v </path/to/transcode>:/transcode \
	-v </path/to/library>:/config \
	-v <path/to/tvseries>:/data/tvshows \
	-v </path/to/movies>:/data/movies \
	linuxserver/plex
```

**Parameters**

* `--net=host` - Shares host networking with container, **required**.
* `-v /config` - Plex library location. *This can grow very large, 50gb+ is likely for a large collection.*
* `-v /transcode` *(optional)* - Transcode directory to offload heavy writes in a docker container.
* `-v /data/xyz` - Media goes here. Add as many as needed e.g. `/data/movies`, `/data/tv`, etc.
* `-e VERSION=` - *(optional)* - Permits specific version selection e.g. `0.9.12.4.1192-9a47d21`, also supports `plexpass` or `latest`
* `-e PGID=` for for GroupID - see below for explanation
* `-e PUID=` for for UserID - see below for explanation

*Special note* - If you'd like to run Plex without requiring `--net=host` then you will need the following ports in your `docker create` command:

  -p 32400:32400 \
  -p 32400:32400/udp \
  -p 32469:32469 \
  -p 32469:32469/udp \
  -p 5353:5353/udp \
  -p 1900:1900/udp

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" <sup>TM</sup>.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

  $ id dockeruser
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)

## Updates / Monitoring

* Shell access whilst the container is running: `docker exec -it plex /bin/bash`
* Upgrade to the latest version: `docker restart plex`
* To monitor the logs of the container in realtime: `docker logs -f plex`

## Changelog

+ **24.09.2015:** added optional support for volume transcoding (/transcode), and various typo fixes.
+ **17.09.2015:** Changed to run chmod only once
+ **19.09.2015:** Plex updated their download servers from http to https
+ **28.08.2015:** Removed plexpass from routine, and now uses VERSION as a combination fix.
+ **18.07.2015:** Moved autoupdate to be hosted by linuxserver.io and implemented bugfix thanks to ljm42.
+ **09.07.2015:** Now with ability to pick static version number.
+ **08.07.2015:** Now with autoupdates. (Hosted by fanart.tv)
+ **03.07.2015:** Fixed a mistake that allowed plex to run as user plex rather than abc (99:100). Thanks to double16 for spotting this.
