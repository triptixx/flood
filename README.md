[hub]: https://hub.docker.com/r/loxoo/flood
[mbdg]: https://microbadger.com/images/loxoo/flood
[git]: https://github.com/triptixx/flood
[actions]: https://github.com/triptixx/flood/actions

# [loxoo/flood][hub]
[![Layers](https://images.microbadger.com/badges/image/loxoo/flood.svg)][mbdg]
[![Latest Version](https://images.microbadger.com/badges/version/loxoo/flood.svg)][hub]
[![Git Commit](https://images.microbadger.com/badges/commit/loxoo/flood.svg)][git]
[![Docker Stars](https://img.shields.io/docker/stars/loxoo/flood.svg)][hub]
[![Docker Pulls](https://img.shields.io/docker/pulls/loxoo/flood.svg)][hub]
[![Build Status](https://github.com/triptixx/flood/workflows/docker%20build/badge.svg)][actions]

## Usage

```shell
docker run -d \
    --name=srvflood \
    --restart=unless-stopped \
    --hostname=srvflood \
    -p 3000:3000 \
    -e FLOOD_SECRET=$(openssl rand -hex 32) \
    -e RTORRENT_SCGI_HOST=localhost \
    -e RTORRENT_SCGI_PORT=5000 \
    -v $PWD/data:/data \
    loxoo/flood
```

## Environment

- `$SUID`               - User ID to run as. _default: `912`_
- `$SGID`               - Group ID to run as. _default: `900`_
- `$FLOOD_BASE_URI`     - The directory to access Flood. _default: `/`
- `$FLOOD_SECRET`       - A key for encrypting session cookie/JWT. _default: `flood`
- `$RTORRENT_SCGI_HOST` - The address of your rtorrent SCGI socket. _default: `localhost`
- `$RTORRENT_SCGI_PORT` - The port of your rtorrent SCGI socket. _default: `5000`
- `$RTORRENT_SOCK`      - Enable UNIX socket connection to rtorrent. _optional_
- `$RTORRENT_SOCK_PATH` - The path of the rtorrent socket. _default: `/data/rtorrent.sock`
- `$FLOOD_ENABLE_SSL`   - Enable bundled SSL encryption. _optional_
- `$TZ`                 - Timezone. _optional_

## Volume

- `/data`               - A path for storing flood data.

## Network

- `3000/tcp`            - The port that Flood should listen for web connections on.
