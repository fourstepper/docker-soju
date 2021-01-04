# soju docker image

[![builds.sr.ht status](https://builds.sr.ht/~fourstepper/docker-soju.svg)](https://builds.sr.ht/~fourstepper/docker-soju?)

soju is an IRC bouncer - https://git.sr.ht/~emersion/soju

## Usage

### Environment variables

**USER** - the admin (main) user

**PASSWORD** - the password for the admin user

**LISTEN_METHOD**, **LISTEN_HOST**, **LISTEN_PORT**

- Check the possible listen directives in the [docs](https://git.sr.ht/~emersion/soju/tree/master/item/doc/soju.1.scd)

### Running the image

**Run the image from the CLI**

`docker run  -e USER='admin' -e PASSWORD='password' -e LISTEN_METHOD='irc+insecure' -e LISTEN_HOST='0.0.0.0' -e LISTEN_PORT='6667' -p 6667:6667 fourstepper/soju`


**Run as part of docker-compose**

```
version: "3.0"
services:
  soju:
    image: fourstepper/docker-soju:latest
    container_name: soju
    restart: unless-stopped
    volumes:
      - ./soju-data:/data
    ports:
      - "6667:6667"
    environment:
      - USER=admin
      - PASSWORD=password
      - LISTEN_METHOD=irc+insecure
      - LISTEN_HOST=0.0.0.0
      - LISTEN_PORT=6667
      - LOG_PATH=/data/irc.log
```
