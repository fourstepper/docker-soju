#!/bin/sh
set -e

container_name="$1"

if [ $(docker inspect -f '{{.State.Running}}' $container_name) = "true" ];
then
  exit 0
else
  echo $(docker logs $container_name)
  exit 1
fi
