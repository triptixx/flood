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
    -e FLOOD_OPTION_secret=$(openssl rand -hex 32) \
    -e FLOOD_OPTION_rthost=localhost \
    -e FLOOD_OPTION_rtport=5000 \
    -v $PWD/data:/data \
    loxoo/flood
```

## Environment

- `$SUID`                          - User ID to run as. _default: `912`_
- `$SGID`                          - Group ID to run as. _default: `900`_
- `$FLOOD_OPTION_baseuri`          - This URI will prefix all of Flood's HTTP requests. _default: `/`
- `$FLOOD_OPTION_rundir`           - Where to store Flood's runtime files (eg. database). _default: `/data`
- `$FLOOD_OPTION_port`             - The port that Flood should listen for web connections on. _default: `3000`
- `$FLOOD_OPTION_secret`           - A unique secret, a random one will be generated if not provided. _optional_
- `$FLOOD_OPTION_noauth`           - Disable Flood's builtin access control system, needs rthost+rtport OR rtsocket. _default: `false`
- `$FLOOD_OPTION_rthost`           - Depends on noauth: Host of rTorrent's SCGI interface. _optional_
- `$FLOOD_OPTION_rtport`           - Depends on noauth: Port of rTorrent's SCGI interface. _optional_
- `$FLOOD_OPTION_rtsocket`         - Depends on noauth: Path to rTorrent's SCGI unix socket. _optional_
- `$FLOOD_OPTION_ssl`              - Enable SSL, key.pem and fullchain.pem needed in runtime directory. _default: `false`
- `$FLOOD_OPTION_sslkey`           - Depends on ssl: Absolute path to private key for SSL. _optional_
- `$FLOOD_OPTION_sslcert`          - Depends on ssl: Absolute path to fullchain cert for SSL. _optional_
- `$FLOOD_OPTION_allowedpath`      - Allowed path for file operations, can be called multiple times. _optional_
- `$FLOOD_OPTION_dbclean`          - Interval between database purge. _default: `1000 * 60 * 60`
- `$FLOOD_OPTION_maxhistorystates` - Number of records of torrent download and upload speeds. _default: `30`
- `$FLOOD_OPTION_clientpoll`       - How often (in ms) Flood will request the torrent list. _default: `1000 * 2`
- `$TZ`                            - Timezone. _optional_

## Volume

- `/data`                          - A path for storing flood data.

## Network

- `3000/tcp`                       - The port that Flood should listen for web connections on.
