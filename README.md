# Caddy HA with Consul for Docker

[![pipeline status](https://gitlab.com/youtous/caddy-consul-docker/badges/master/pipeline.svg)](https://gitlab.com/youtous/caddy-consul-docker/-/commits/master)
[![Docker image](https://img.shields.io/badge/image-registry.gitlab.com%2Fyoutous%2Fcaddy--consul--docker-e4f0fb?logo=docker)](https://gitlab.com/youtous/caddy-consul-docker/container_registry/1687721)
[![GitHub Repo stars](https://img.shields.io/github/stars/youtous/caddy-consul-docker?label=✨%20youtous%2Fcaddy-consul-docker&style=social)](https://github.com/youtous/caddy-consul-docker/)
[![Gitlab Repo](https://img.shields.io/badge/gitlab.com%2Fyoutous%2Fcaddy--consul--docker?label=✨%20youtous%2Fcaddy-consul-docker&style=social&logo=gitlab)](https://gitlab.com/youtous/caddy-consul-docker/)
[![License](https://img.shields.io/github/license/youtous/caddy-consul-docker)](https://github.com/youtous/caddy-consul-docker/blob/master/LICENSE)

## Description

Custom Caddy build using Consul for certificates storage and reading docker labels for on-the-fly configuration.

Plugins shipped with the build:
 - Caddy configuration from docker labels (use Caddy as an ingress controller): [Caddy-Docker-Proxy](https://github.com/lucaslorentz/caddy-docker-proxy/)
 - Consul TLS K/V (stores certificates in a distributed system): [caddy-tlsconsul](https://github.com/pteich/caddy-tlsconsul)
 - Rate limit (limits requests using caddy directives): [caddy-ratelimit](https://github.com/hundertzehn/caddy-ratelimit).
 - Cache system (simple caching using caddy directive): [cdp-cache](https://github.com/sillygod/cdp-cache).
 - TCP/UDP Layer (supports l4 layer): [caddy-l4](https://github.com/mholt/caddy-l4).
 - Caddy Transform Encoder Module (enables custom logging format: fail2ban, apache2, nginx, etc): [caddy-transform-encoder](https://github.com/caddyserver/transform-encoder).

Based on the work of https://p1ngouin.com/posts/why-i-migrated-from-traefik-to-caddy.

```
docker run -d -p 80:80 \
    -v $PWD/index.html:/usr/share/caddy/index.html \
    -v caddy_data:/data \
    registry.gitlab.com/youtous/caddy-consul-docker
```

:heartpulse: [Healtcheck](https://docs.docker.com/engine/reference/builder/#healthcheck) built-in.
