![https://linuxserver.io](https://www.linuxserver.io/wp-content/uploads/2015/06/linuxserver_medium.png)

The [LinuxServer.io](https://linuxserver.io) team brings you another quality container release featuring auto-update on startup, easy user mapping and community support. Be sure to checkout our [forums](https://forum.linuxserver.io) or for real-time support our [IRC](https://www.linuxserver.io/index.php/irc/) on freenode at `#linuxserver.io`.

# linuxserver/plex

[Plex](https://plex.tv/) organizes video, music and photos from personal media libraries and streams them to smart TVs, streaming boxes and mobile devices. This container is packaged as a standalone Plex Media Server.

![](https://press.plex.tv/wp-content/themes/plex-press/img/assets/plex-pms-icon.png)

## Usage

```
docker create \
	--name=plex \ 
	--net=host \
	-e VERSION="plexpass" \
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
* `-e VERSION` - Set this to a full version number if you want to use a specific version e.g. `0.9.12.4.1192-9a47d21`, or set it to `plexpass` or `latest`
* `-e PGID` for for GroupID - see below for explanation
* `-e PUID` for for UserID - see below for explanation

### User / Group Identifiers

**TL;DR** - The `PGID` and `PUID` values set the user / group you'd like your container to 'run as' to the host OS. This can be a user you've created or even root (not recommended).

Part of what makes our containers work so well is by allowing you to specify your own `PUID` and `PGID`. This avoids nasty permissions errors with relation to data volumes (`-v` flags). When an application is installed on the host OS it is normally added to the common group called users, Docker apps due to the nature of the technology can't be added to this group. So we added this feature to let you easily choose when running your containers.  

## Updates / Monitoring

* Upgrade to the latest version of Plex simply `docker restart plex`.
* Monitor the logs of the container in realtime `docker logs -f plex`.

## Changelog

+ **24.09.2015:** added optional support for volume transcoding (/transcode), and various typo fixes.
+ **17.09.2015:** Changed to run chmod only once
+ **19.09.2015:** Plex updated their download servers from http to https
+ **28.08.2015:** Removed plexpass from routine, and now uses VERSION as a combination fix.
+ **18.07.2015:** Moved autoupdate to be hosted by linuxserver.io and implemented bugfix thanks to ljm42.
+ **09.07.2015:** Now with ability to pick static version number.
+ **08.07.2015:** Now with autoupdates. (Hosted by fanart.tv)
+ **03.07.2015:** Fixed a mistake that allowed plex to run as user plex rather than abc (99:100). Thanks to double16 for spotting this.
