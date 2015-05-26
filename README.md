# linuxserver/plex

##Description:
This Continer is self-contained [Plex](https://plex.tv/) Container. 


####[Plex](https://plex.tv/)
Plex organizes video, music and photos from personal media libraries and streams them to smart TVs, streaming boxes and mobile devices. It is a media player system and software suite consisting of many player applications for 10-foot user interfaces and an associated media server that organizes personal media stored on local devices. It is available for Windows, Linux, OS X and FreeBSD.[1] Integrated Plex Channels provide users with access to a growing number of online content providers such as YouTube, Vimeo, TEDTalks, and CNN among others. Plex also provides integration for cloud services[2] including Dropbox, Box, Google Drive, Copy and Bitcasa.[3]


##Ports and mappings:

- **--net=host** Must be set for this container to work
- **/config** Will store your plex library\plugins and related files
- **/data/*** Map as many as you need for your media library
- **PUID** What UID it will run under.
- **PGID** What GID it wil run under.
- **PLEXPASS** Set to 1 if you have a plexpass subscription. otherwise blank (non-exsistent)


## Sample create command:

> *docker create --name=<name> --net=host -e PUID=<UID> -e PGID <GID> -v </path/to/library>:/config -v <path/to/tvseries>:/data/tvshows -v </path/to/films>:/data/film linuxserver/plex*