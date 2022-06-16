#!/usr/bin/env bash
DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";

source "${DIR}"/config.sh

rocker \
    --nvidia \
    --x11 \
    --volume="${DIR}/..":"/${WORKSPACE_NAME}":rw \
    --user \
    --name "${CONTAINER_NAME}" \
    --privileged \ # required for gdb
    -- \
    "${IMAGE_NAME}" \
    bash

 #docker run -it --net=host --gpus all \
     #--env="NVIDIA_DRIVER_CAPABILITIES=all" \
     #--env="DISPLAY" \
     #--env="QT_X11_NO_MITSHM=1" \
     #--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
     #--volume="${DIR}/..":"/${WORKSPACE_NAME}":rw \
     #--privileged \ # for gdb
     #-u $(id -u ${USER}):$(id -g ${USER})
     #"${IMAGE_NAME}" \
     #bash
