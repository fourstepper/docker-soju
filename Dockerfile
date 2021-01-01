FROM golang:alpine

RUN apk update && apk add --no-cache git gcc make musl-dev scdoc

VOLUME /data

WORKDIR /src

RUN git clone https://git.sr.ht/~emersion/soju && cd soju && make install

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
