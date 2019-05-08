[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)](https://linuxserver.io)

The [LinuxServer.io](https://linuxserver.io) team brings you another container release featuring :-

 * regular and timely application updates
 * easy user mappings (PGID, PUID)
 * custom base image with s6 overlay
 * weekly base OS updates with common layers across the entire LinuxServer.io ecosystem to minimise space usage, down time and bandwidth
 * regular security updates

Find us at:
* [Discord](https://discord.gg/YWrKVTn) - realtime support / chat with the community and the team.
* [IRC](https://irc.linuxserver.io) - on freenode at `#linuxserver.io`. Our primary support channel is Discord.
* [Blog](https://blog.linuxserver.io) - all the things you can do with our containers including How-To guides, opinions and much more!

# [linuxserver/plex](https://github.com/linuxserver/docker-plex)
[![](https://img.shields.io/discord/354974912613449730.svg?logo=discord&label=LSIO%20Discord&style=flat-square)](https://discord.gg/YWrKVTn)
[![](https://images.microbadger.com/badges/version/linuxserver/plex.svg)](https://microbadger.com/images/linuxserver/plex "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/linuxserver/plex.svg)](https://microbadger.com/images/linuxserver/plex "Get your own version badge on microbadger.com")
![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/plex.svg)
![Docker Stars](https://img.shields.io/docker/stars/linuxserver/plex.svg)
[![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Pipeline-Builders/docker-plex/master)](https://ci.linuxserver.io/job/Docker-Pipeline-Builders/job/docker-plex/job/master/)
[![](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/plex/latest/badge.svg)](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/plex/latest/index.html)

[Plex](https://plex.tv) organizes video, music and photos from personal media libraries and streams them to smart TVs, streaming boxes and mobile devices. This container is packaged as a standalone Plex Media Server. has always been a top priority. Straightforward design and bulk actions mean getting things done faster.

[![plex](http://the-gadgeteer.com/wp-content/uploads/2015/10/plex-logo-e1446990678679.png)](https://plex.tv)

## Supported Architectures

Our images support multiple architectures such as `x86-64`, `arm64` and `armhf`. We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list) and our announcement [here](https://blog.linuxserver.io/2019/02/21/the-lsio-pipeline-project/). 

Simply pulling `linuxserver/plex` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

| Architecture | Tag |
| :----: | --- |
| x86-64 | amd64-latest |
| arm64 | arm64v8-latest |
| armhf | arm32v7-latest |


## Usage

Here are some example snippets to help you get started creating a container.

### docker

```
docker create \
  --name=plex \
  --net=host \
  -e PUID=1000 \
  -e PGID=1000 \
  -e VERSION=docker \
  -v </path/to/library>:/config \
  -v <path/to/tvseries>:/data/tvshows \
  -v </path/to/movies>:/data/movies \
  -v </path for transcoding>:/transcode \
  --restart unless-stopped \
  linuxserver/plex
```


### docker-compose

Compatible with docker-compose v2 schemas.

```
---
version: "2"
services:
  plex:
    image: linuxserver/plex
    container_name: plex
    network_mode: host
    environment:
      - PUID=1000
      - PGID=1000
      - VERSION=docker
    volumes:
      - </path/to/library>:/config
      - <path/to/tvseries>:/data/tvshows
      - </path/to/movies>:/data/movies
      - </path for transcoding>:/transcode
    restart: unless-stopped
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `--net=host` | Use Host Networking |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e VERSION=docker` | Set whether to update plex or not - see Application Setup section. |
| `-v /config` | Plex library location. *This can grow very large, 50gb+ is likely for a large collection.* |
| `-v /data/tvshows` | Media goes here. Add as many as needed e.g. `/data/movies`, `/data/tv`, etc. |
| `-v /data/movies` | Media goes here. Add as many as needed e.g. `/data/movies`, `/data/tv`, etc. |
| `-v /transcode` | Path for transcoding folder, *optional*. |

## Optional Parameters

*Special note* - If you'd like to run Plex without requiring `--net=host` (`NOT recommended`) then you will need the following ports in your `docker create` command:

```
  -p 32400:32400 \
  -p 32400:32400/udp \
  -p 32469:32469 \
  -p 32469:32469/udp \
  -p 5353:5353/udp \
  -p 1900:1900/udp
```

The application accepts a series of environment variables to further customize itself on boot:

| Parameter | Function |
| :---: | --- |
| `-v /transcode` | Path for transcoding folder|
| `--device=/dev/dri:/dev/dri` | Add this option to your run command if you plan on using Quicksync hardware acceleration - see Application Setup section.|


## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```


&nbsp;
## Application Setup

Webui can be found at `<your-ip>:32400/web`

** Note about updates, if there is no value set for the VERSION variable, then no updates will take place.**

** For new users, no updates will take place on the first run of the container as there is no preferences file to read your token from, to update restart the Docker container after logging in through the webui**

Valid settings for VERSION are:-

`IMPORTANT NOTE:- YOU CANNOT UPDATE TO A PLEXPASS ONLY (BETA) VERSION IF YOU ARE NOT LOGGED IN WITH A PLEXPASS ACCOUNT`

+ **`docker`**: Let Docker handle the Plex Version, we keep our Dockerhub Endpoint up to date with the latest public builds. This is the same as leaving this setting out of your create command.
+ **`latest`**: will update plex to the latest version available that you are entitled to.
+ **`public`**: will update plexpass users to the latest public version, useful for plexpass users that don't want to be on the bleeding edge but still want the latest public updates.
+ **`<specific-version>`**: will select a specific version (eg 0.9.12.4.1192-9a47d21) of plex to install, note you cannot use this to access plexpass versions if you do not have plexpass.

Hardware acceleration users for Intel Quicksync will need to mount their /dev/dri video device inside of the container by passing the following command when running or creating the container:

```--device=/dev/dri:/dev/dri```

We will automatically ensure the abc user inside of the container has the proper permissions to access this device.

Hardware acceleration users for Nvidia will need to install the container runtime provided by Nvidia on their host, instructions can be found here:

https://github.com/NVIDIA/nvidia-docker

We automatically add the necessary environment variable that will utilise all the features available on a GPU on the host. Once nvidia-docker is installed on your host you will need to re/create the docker container with the nvidia container runtime `--runtime=nvidia` and add an environment variable `-e NVIDIA_VISIBLE_DEVICES=all` (can also be set to a specific gpu's UUID, this can be discovered by running `nvidia-smi --query-gpu=gpu_name,gpu_uuid --format=csv` ). NVIDIA automatically mounts the GPU and drivers from your host into the plex docker.



## Support Info

* Shell access whilst the container is running: `docker exec -it plex /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f plex`
* container version number 
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' plex`
* image version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/plex`

## Updating Info

Most of our images are static, versioned, and require an image update and container recreation to update the app inside. With some exceptions (ie. nextcloud, plex), we do not recommend or support updating apps inside the container. Please consult the [Application Setup](#application-setup) section above to see if it is recommended for the image.  
  
Below are the instructions for updating containers:  
  
### Via Docker Run/Create
* Update the image: `docker pull linuxserver/plex`
* Stop the running container: `docker stop plex`
* Delete the container: `docker rm plex`
* Recreate a new container with the same docker create parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* Start the new container: `docker start plex`
* You can also remove the old dangling images: `docker image prune`

### Via Docker Compose
* Update all images: `docker-compose pull`
  * or update a single image: `docker-compose pull plex`
* Let compose update all containers as necessary: `docker-compose up -d`
  * or update a single container: `docker-compose up -d plex`
* You can also remove the old dangling images: `docker image prune`

### Via Watchtower auto-updater (especially useful if you don't remember the original parameters)
* Pull the latest image at its tag and replace it with the same env variables in one run:
  ```
  docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  containrrr/watchtower \
  --run-once plex
  ```
* You can also remove the old dangling images: `docker image prune`

## Building locally

If you want to make local modifications to these images for development purposes or just to customize the logic: 
```
git clone https://github.com/linuxserver/docker-plex.git
cd docker-plex
docker build \
  --no-cache \
  --pull \
  -t linuxserver/plex:latest .
```

The ARM variants can be built on x86_64 hardware using `multiarch/qemu-user-static`
```
docker run --rm --privileged multiarch/qemu-user-static:register --reset
```

Once registered you can define the dockerfile to use with `-f Dockerfile.aarch64`.

## Versions

* **23.03.19:** - Switching to new Base images, shift to arm32v7 tag.
* **22.03.19:** - Fix update logic for `VERSION=public`.
* **14.03.19:** - Switch to new api endpoints, enable beta (plex pass) updates for armhf and aarch64.
* **15.02.19:** - Clean up plex pid after unclean stop.
* **11.02.19:** - Fix nvidia variables, add device variables.
* **16.01.19:** - Add pipeline logic, multi arch, and HW transcoding configuration; remove avahi service.
* **07.09.18:** - Rebase to ubuntu bionic, add udev package.
* **09.12.17:** - Fix continuation lines.
* **12.07.17:** - Add inspect commands to README, move to jenkins build and push.
* **28.05.17:** - Add unrar package as per requests, for subzero plugin.
* **11.01.17:** - Use Plex environment variables from pms docker, change abc home folder to /app to alleviate usermod chowning library
* **03.01.17:** - Use case insensitive version variable matching rather than export and make lowercase.
* **17.10.16:** - Allow use of uppercase version variable
* **01.10.16:** - Add TZ info to README.
* **09.09.16:** - Add layer badges to README.
* **27.08.16:** - Add badges to README.
* **22.08.16:** - Rebased to xenial and s6 overlay
* **07.04.16:** - removed `/transcode` volume support (upstream Plex change) and modified PlexPass download method to prevent unauthorised usage of paid PMS
* **24.09.15:** - added optional support for volume transcoding (/transcode), and various typo fixes.
* **17.09.15:** - Changed to run chmod only once
* **19.09.15:** - Plex updated their download servers from http to https
* **28.08.15:** - Removed plexpass from routine, and now uses VERSION as a combination fix.
* **18.07.15:** - Moved autoupdate to be hosted by linuxserver.io and implemented bugfix thanks to ljm42.
* **09.07.15:** - Now with ability to pick static version number.
* **08.07.15:** - Now with autoupdates. (Hosted by fanart.tv)
* **03.07.15:** - Fixed a mistake that allowed plex to run as user plex rather than abc (99:100). Thanks to double16 for spotting this.
