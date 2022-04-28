#!/usr/bin/env bash
DIR=$(dirname "$(readlink -f "$0")")

source "${DIR}"/config.sh

docker exec -it ${CONTAINER_NAME} bash