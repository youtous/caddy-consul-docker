FROM golang:1.15-alpine AS builder

ENV CGO_ENABLED=0
ENV GO111MODULE=on

WORKDIR /src/app

COPY go.mod go.sum ./
RUN apk add --no-cache git \
    && go mod download

COPY . .
RUN go install

FROM alpine:latest
LABEL maintainer="youtous <contact@youtous.me>"

RUN apk add --no-cache ca-certificates mailcap curl

RUN set -eux; \
	mkdir -p \
		/config/caddy \
		/data/caddy \
		/etc/caddy \
		/usr/share/caddy \
	; \
	wget -O /etc/caddy/Caddyfile "https://github.com/caddyserver/dist/raw/56302336e0bb7c8c5dff34cbcb1d833791478226/config/Caddyfile"; \
	wget -O /usr/share/caddy/index.html "https://github.com/caddyserver/dist/raw/56302336e0bb7c8c5dff34cbcb1d833791478226/welcome/index.html"


# set up nsswitch.conf for Go's "netgo" implementation
# - https://github.com/docker-library/golang/blob/1eb096131592bcbc90aa3b97471811c798a93573/1.14/alpine3.12/Dockerfile#L9
RUN [ ! -e /etc/nsswitch.conf ] && echo 'hosts: files dns' > /etc/nsswitch.conf

# See https://caddyserver.com/docs/conventions#file-locations for details
ENV XDG_CONFIG_HOME /config
ENV XDG_DATA_HOME /data

VOLUME /config
VOLUME /data

LABEL org.opencontainers.image.title=Caddy
LABEL org.opencontainers.image.description="a powerful, enterprise-ready, open source web server with automatic HTTPS written in Go"
LABEL org.opencontainers.image.url=https://caddyserver.com
LABEL org.opencontainers.image.documentation=https://caddyserver.com/docs
LABEL org.opencontainers.image.vendor="youtous.me"
LABEL org.opencontainers.image.licenses=Apache-2.0
LABEL org.opencontainers.image.source="https://github.com/youtous/caddy-consul-docker"

EXPOSE 80
EXPOSE 443
EXPOSE 2019

WORKDIR /srv

COPY --from=builder /go/bin/caddy-consul-docker /usr/local/bin/caddy

HEALTHCHECK CMD curl --silent --fail http://localhost:80/ > /dev/null || exit 1

CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]