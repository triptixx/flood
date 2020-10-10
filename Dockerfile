ARG ALPINE_TAG=3.12
ARG FLOOD_VER=3.1.0

FROM node:alpine AS builder

### install flood
WORKDIR /output/flood
RUN apk add --no-cache build-base git python; \
    git clone https://github.com/jesec/flood.git -b v${FLOOD_VER} /flood-src; \
    cp -a /flood-src/package.json /flood-src/package-lock.json /flood-src/.babelrc \
        /flood-src/.eslintrc.js /flood-src/.eslintignore \
        /flood-src/.prettierrc /flood-src/ABOUT.md .; \
    npm install; \
    cp -a /flood-src/client /flood-src/server /flood-src/shared /flood-src/scripts .; \
    cp -a /flood-src/config.docker.js ./config.js; \
    sed -i "s/^\(\s*secret:\s*\).*$/\1 process.env.FLOOD_SECRET || 'flood',/"  ./config.js; \
    npm run build; \
    npm prune --production; \
    find ./node_modules/* -name 'node_modules' -type d -prune -print -exec rm -rf '{}' \;

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

WORKDIR /flood
RUN apk add --no-cache npm mediainfo

VOLUME ["/data"]

EXPOSE 3000/TCP

HEALTHCHECK --start-period=10s --timeout=5s \
    CMD wget -qO /dev/null "http://localhost:3000/login"

ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/entrypoint.sh"]
CMD ["npm", "start"]