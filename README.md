![http://linuxserver.io](http://www.linuxserver.io/wp-content/uploads/2015/06/linuxserver_medium.png)

The [LinuxServer.io](http://linuxserver.io) team brings you another quality container release featuring auto-update on startup, easy user mapping and community support. Be sure to checkout our [forums](http://forum.linuxserver.io) or for real-time support our [IRC](http://www.linuxserver.io/index.php/irc/) on freenode at `#linuxserver.io`.

# linuxserver/plex

[Plex](https://plex.tv/) organizes video, music and photos from personal media libraries and streams them to smart TVs, streaming boxes and mobile devices. This container is packaged as a standalone Plex Media Server.

![](https://plex.tv/assets/img/everywhere-img-en-2023ecb8d6373416cf9e7dc247d83951.jpg)

## Usage

```
docker create --name=plex --net=host -e PLEXPASS=1 -e PUID=<UID> -e PGID=<GID> -v </path/to/library>:/config -v <path/to/tvseries>:/data/tvshows -v </path/to/movies>:/data/movies linuxserver/plex
```

**Parameters**

* `--net=host` - Shares host networking with container, **required**.
* `-v` /config - Plex library location. *This can grow very large, 50gb+ is likely for a large collection.*
* `-v` /data/xyz - Media goes here. Add as many as needed e.g. `/data/movies`, `/data/tv`, etc.
* `-e` PLEXPASS=1 - Set to 1 if you have a Plex Pass, if not don't specify it.
* `-e` PGID for for GroupID
* `-e` PUID for for UserID

## Updates

* Upgrade to the latest version simply `docker restart plex`.
* To monitor the logs of the container in realtime `docker logs -f plex`.


**Credits**

* lonix <lonixx@gmail.com>
* IronicBadger <ironicbadger@linuxserver.io>