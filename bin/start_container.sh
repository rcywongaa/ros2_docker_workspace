#!/usr/bin/env bash
DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";

source "${DIR}"/config.sh

# privileged is required for gdb

# Do not run with --user to avoid host shell settings (e.g. zsh) from affecting container
rocker \
  --nvidia \
  --x11 \
  --volume="${DIR}/..":"/${WORKSPACE_NAME}":rw \
  --name "${CONTAINER_NAME}" \
  --privileged \
  -- \
  "${IMAGE_NAME}" \
  bash

# Using
# --volume="/etc/group:/etc/group:ro" \
# --volume="/etc/passwd:/etc/passwd:ro" \
# --volume="/etc/shadow:/etc/shadow:ro" \
# -u $(id -u):$(id -g) \
# doesn't work as host user home directory still doesn't exist
# which is needed for ROS logging

# xhost local:root
# docker run -it \
#   --rm \
#   --net=host \
#   --gpus all \
#   --name ${WORKSPACE_NAME} \
#   --env="NVIDIA_DRIVER_CAPABILITIES=all" \
#   --env="DISPLAY=${DISPLAY}" \
#   --env="QT_X11_NO_MITSHM=1" \
#   --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
#   --volume="${DIR}/..":"/${WORKSPACE_NAME}":rw \
#   --privileged \
#   "${IMAGE_NAME}" \
#   bash
