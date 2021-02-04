# Caddy HA with Consul for Docker

[![pipeline status](https://gitlab.com/youtous/caddy-consul-docker/badges/master/pipeline.svg)](https://gitlab.com/youtous/caddy-consul-docker/-/commits/master) 
[![Docker image size](https://img.shields.io/docker/image-size/youtous/caddy-consul-docker)](https://hub.docker.com/r/youtous/caddy-consul-docker/) 
[![Docker hub](https://img.shields.io/badge/hub-youtous%2Fcaddy-consul-docker-099cec?logo=docker)](https://hub.docker.com/r/youtous/caddy-consul-docker/) 
[![Licence](https://img.shields.io/github/license/youtous/caddy-consul-docker)](https://github.com/youtous/caddy-consul-docker/blob/master/LICENSE) 

- docker hub: https://hub.docker.com/r/youtous/caddy-consul-docker
- github repo: https://github.com/youtous/caddy-consul-docker

## Description

Custom Caddy build using Consul for certificates storage and reading docker labels for on-the-fly configuration.

Plugins shipped with the build:
 - Caddy configuration from docker labels: [Caddy-Docker-Proxy](https://github.com/lucaslorentz/caddy-docker-proxy/)
 - Consul TLS K/V: [caddy-tlsconsul](https://github.com/pteich/caddy-tlsconsul)
 - Rate limit: [caddy-ratelimit](https://github.com/hundertzehn/caddy-ratelimit).

Based on the work of https://p1ngouin.com/posts/why-i-migrated-from-traefik-to-caddy.

```
docker run -d -p 80:80 \
    -v $PWD/index.html:/usr/share/caddy/index.html \
    -v caddy_data:/data \
    youtous/caddy-consul-docker
```

:heartpulse: [Healtcheck](https://docs.docker.com/engine/reference/builder/#healthcheck) built-in.