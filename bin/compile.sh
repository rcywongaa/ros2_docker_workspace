#!/usr/bin/env bash
DIR=$(dirname "$(readlink -f "$0")")

source "${DIR}"/config.sh

rocker \
    --volume="${DIR}/..":"/${WORKSPACE_NAME}":rw \
    --user \
    -- \
    "${IMAGE_NAME}" \
    "bash -c \"cd /${WORKSPACE_NAME} && colcon build --cmake-args '-DCMAKE_EXPORT_COMPILE_COMMANDS=1 $@'\""
# Note this only limit the number of threads per package.
# Multiple packages may build in parallel using more threads than specified
# See https://answers.ros.org/question/368249/colcon-build-number-of-threads/

# docker run -it --net=host --gpus all \
#     --env="NVIDIA_DRIVER_CAPABILITIES=all" \
#     --env="DISPLAY" \
#     --env="QT_X11_NO_MITSHM=1" \
#     --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
#     --volume="${DIR}/..":"/${WORKSPACE_NAME}":rw \
#     "${IMAGE_NAME}" \
#     bash -c "cd /${WORKSPACE_NAME} && colcon build"