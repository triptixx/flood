ARG ALPINE_TAG=3.12
ARG FLOOD_VER=3.1.0

FROM node:alpine AS builder

ARG FLOOD_VER

### install flood
WORKDIR /output/flood
RUN apk add --no-cache git; \
    git clone https://github.com/jesec/flood.git --branch v${FLOOD_VER} --depth 1 .; \
    npm set unsafe-perm true; \
    npm install; \
    cp ./config.cli.js ./config.js; \
    npm run build; \
    npm prune --production; \
    npm pack --ignore-scripts; \
    DESTDIR=/output npm install -g *.tgz --unsafe-perm

COPY *.sh /output/usr/local/bin/
RUN chmod +x /output/usr/local/bin/*.sh

#============================================================

FROM loxoo/alpine:${ALPINE_TAG}

ARG FLOOD_VER
ENV SUID=912 SGID=900

LABEL org.label-schema.name="flood" \
      org.label-schema.description="A Docker image for flood web UI for rTorrent" \
      org.label-schema.url="https://github.com/jesec/flood.git" \
      org.label-schema.version=${FLOOD_VER}

COPY --from=builder /output/ /

RUN apk add --no-cache npm mediainfo

VOLUME ["/data"]

EXPOSE 3000/TCP

HEALTHCHECK --start-period=10s --timeout=5s \
    CMD wget -qO /dev/null "http://localhost:3000/login"

ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/entrypoint.sh"]
CMD ["flood", "--rundir=/data", "--host=0.0.0.0"]
