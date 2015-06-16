![http://linuxserver.io](http://www.linuxserver.io/wp-content/uploads/2015/06/linuxserver_medium.png)

The [LinuxServer.io](http://linuxserver.io) team brings you another quality container release featuring auto-update on startup, easy user mapping and community support. Be sure to checkout our [forums](http://forum.linuxserver.io) or for real-time support our [IRC](http://www.linuxserver.io/index.php/irc/) on freenode at `#linuxserver.io`.

# linuxserver/plex

[Plex](https://plex.tv/) organizes video, music and photos from personal media libraries and streams them to smart TVs, streaming boxes and mobile devices. This container is packaged as a standalone Plex Media Server.

![](https://plex.tv/assets/img/everywhere-img-en-2023ecb8d6373416cf9e7dc247d83951.jpg)

## Usage

```
docker create 
	--name=plex \ 
	--net=host \
	-e PLEXPASS=1 \
	-e PUID=<UID> -e PGID=<GID> \
	-v </path/to/library>:/config \
	-v <path/to/tvseries>:/data/tvshows \
	-v </path/to/movies>:/data/movies \
	linuxserver/plex
```

**Parameters**

* `--net=host` - Shares host networking with container, **required**.
* `-v` /config - Plex library location. *This can grow very large, 50gb+ is likely for a large collection.*
* `-v` /data/xyz - Media goes here. Add as many as needed e.g. `/data/movies`, `/data/tv`, etc.
* `-e` PLEXPASS=1 - Set to 1 if you have a Plex Pass, if not don't specify it.
* `-e` PGID for for GroupID - see below for explanation
* `-e` PUID for for UserID - see below for explanation

### User / Group Identifiers

Part of what makes our containers work so well is by allowing you to specify your own `PUID` and `PGID`. This avoids nasty permissions errors with relation to data volumes (`-v` flags). When an application is installed on the host OS it is normally added to the common group called users, Docker apps due to the nature of the technology can't be added to this group. 

In summary the `PGID` and `PUID` values set the user / group you'd like your container to 'run as' to the host OS. This can be a user you've created or even root (not recommended).

#### unRAID notes

If you wish to run this container on unRAID use the following values:

* `-e PUID=99` (nobody)
* `-e PGID=100` (users)

## Updates

* Upgrade to the latest version simply `docker restart plex`.
* To monitor the logs of the container in realtime `docker logs -f plex`.


**Credits**

* lonix <lonixx@gmail.com>
* IronicBadger <ironicbadger@linuxserver.io>

Auto-updating Ubuntu (phusion) based Plex Media Server container, brought to you by LinuxServer.io