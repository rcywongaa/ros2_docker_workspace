#!/usr/bin/env bash
DIR=$(dirname "$(readlink -f "$0")")

source "${DIR}"/config.sh

rocker \
    --nvidia \
    --x11 \
    --volume="${DIR}/..":"/${WORKSPACE_NAME}":rw \
    --user \
    --name "${CONTAINER_NAME}" \
    -- \
    "${IMAGE_NAME}" \
    bash

# docker run -it --net=host --gpus all \
#     --env="NVIDIA_DRIVER_CAPABILITIES=all" \
#     --env="DISPLAY" \
#     --env="QT_X11_NO_MITSHM=1" \
#     --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
#     --volume="${DIR}/..":"/${WORKSPACE_NAME}":rw \
#     "${IMAGE_NAME}" \
#     bash