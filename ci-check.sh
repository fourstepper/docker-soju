#!/bin/sh
set -e

## SPECIFY CONTAINER NAME AS FIRST ARGUMENT, SLEEP TIME AS SECOND

sleep $2

container_name="$1"

if [ $(docker inspect -f '{{.State.Running}}' $container_name) = "true" ];
then
  echo "The container is running - all OK"
  exit 0
else
  echo "The container is not running; it probably failed when starting"
  echo "Here are the logs:"
  echo $(docker logs $container_name)
  exit 1
fi
