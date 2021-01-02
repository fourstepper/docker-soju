#!/bin/sh
set -e

CONFIG=/data/soju.cfg

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

if [ -z "$HOSTNAME" ] && [ ! -f $CONFIG ]
then
    echo "Please make sure to define the HOSTNAME variable"
    echo "For example: 'example.com'"
    exit 1
fi

if [ -z "$LISTEN_METHOD" ] && [ ! -f $CONFIG ]
then
    echo "Please make sure to define the LISTEN_METHOD variable"
    echo "See https://git.sr.ht/~emersion/soju/tree/master/item/doc/soju.1.scd for examples"
    exit 1
fi

if [ -z "$LISTEN_METHOD" ] && [ ! -f $CONFIG ]
then
    echo "LISTEN_HOST variable undefined, falling back to 'localhost'"
    LISTEN_HOST="localhost"
fi

if [ -z "$LISTEN_PORT" ] && [ ! -f $CONFIG ]
then
    echo "LISTEN_PORT variable undefined, falling back to 6667"
    LISTEN_PORT="6667"
fi

if [ -e $CONFIG ]
then
    echo "soju config exists, not regenerating"
else
    echo -n "$PASSWORD" | sojuctl -c $CONFIG create-user $USER -admin
    touch $CONFIG
    echo "listen $LISTEN_METHOD://$LISTEN_HOST:$LISTEN_PORT" >> $CONFIG
    echo "hostname $HOSTNAME" >> $CONFIG
    echo "sql sqlite3 /data/soju.db" >> $CONFIG
fi

soju -config $CONFIG
