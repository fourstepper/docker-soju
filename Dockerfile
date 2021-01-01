FROM golang:alpine

RUN apk update && apk add --no-cache git gcc make musl-dev scdoc

WORKDIR /src

RUN git clone https://git.sr.ht/~emersion/soju && cd soju && \
    go build -ldflags "-linkmode external -extldflags -static" ./cmd/soju &&\
    go build -ldflags "-linkmode external -extldflags -static" ./cmd/sojuctl &&\
    pwd && ls -la

FROM alpine:latest

VOLUME /data

COPY --from=0 /src/soju/soju /usr/local/bin/
COPY --from=0 /src/soju/sojuctl /usr/local/bin/

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
