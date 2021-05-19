#!/bin/sh
set -e

BASE_PATH="/data"
CONFIG="$BASE_PATH/soju.cfg"

if [ -z "$USER" ] && [ ! -f $CONFIG ]
then
    echo "Please make sure to define the USER variable"
    echo "This will be the admin user"
    exit 1
fi

if [ -z "$PASSWORD" ] && [ ! -f $CONFIG ]
then
    echo "Please make sure to define the PASSWORD variable"
    echo "This is the password for your admin user"
    exit 1
fi

if [ -z "$LISTEN_METHOD" ] && [ ! -f $CONFIG ]
then
    echo "Please make sure to define the LISTEN_METHOD variable"
    echo "See https://git.sr.ht/~emersion/soju/tree/master/item/doc/soju.1.scd for examples"
    exit 1
fi

if [ -z "$LISTEN_HOST" ] && [ ! -f $CONFIG ]
then
    echo "LISTEN_HOST variable undefined, falling back to '0.0.0.0' (recommended for Docker deployments)"
    LISTEN_HOST="0.0.0.0"
fi

if [ -z "$LISTEN_PORT" ] && [ ! -f $CONFIG ]
then
    echo "LISTEN_PORT variable undefined, falling back to 6667"
    LISTEN_PORT="6667"
fi

if [ -e "$BASE_PATH/soju.db" ]
then
    cd $BASE_PATH && echo -n "$PASSWORD" | sojuctl -config $CONFIG create-user $USER -admin
fi

touch $CONFIG
echo "listen $LISTEN_METHOD://$LISTEN_HOST:$LISTEN_PORT" > $CONFIG
echo "db sqlite3 /data/soju.db" >> $CONFIG
echo "New config generated\n"
if [ -z $LOG_PATH ]
then
    echo "LOG_PATH not specified, not adding to $CONFIG\n"
else
    echo "log fs $LOG_PATH" >> $CONFIG
fi

cd $BASE_PATH && soju -config $CONFIG
