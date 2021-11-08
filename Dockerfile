# Expose a WireGuard connection as SOCKS5 proxy
#
# Usage:
# 1. start.sh /path/to/your/wireguard/conf
# 2. SOCKS5 proxy will be available at 1080
#
# `start.sh` is a one line script, feel free to tweak it e.g. the port mapping

FROM alpine:3.10.2

RUN apk update && apk add --update-cache wireguard-tools openresolv ip6tables iptables \
  && rm -rf /var/cache/apk/*

RUN printf "https://dl-3.alpinelinux.org/alpine/v3.12/main\nhttps://dl-3.alpinelinux.org/alpine/v3.12/community" > /etc/apk/repositories \
    && apk update && apk add dante-server

COPY ./sockd.conf /etc/
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +rwx /entrypoint.sh

ENTRYPOINT "/entrypoint.sh"
