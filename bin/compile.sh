#!/usr/bin/env bash
DIR=$(dirname "$(readlink -f "$0")")

source "${DIR}"/config.sh

BUILD_ARGS="--cmake-args '-DCMAKE_EXPORT_COMPILE_COMMANDS=1'"

if [ ! -z "$1" ]; then
  BUILD_ARGS="--parallel-workers $1 --cmake-args '-DCMAKE_EXPORT_COMPILE_COMMANDS=1 -j$1'"
fi

rocker \
    --volume="${DIR}/..":"/${WORKSPACE_NAME}":rw \
    --user \
    -- \
    "${IMAGE_NAME}" \
    "bash -c \"cd /${WORKSPACE_NAME} && colcon build $BUILD_ARGS\""
# See https://answers.ros.org/question/368249/colcon-build-number-of-threads/

# docker run -it --net=host --gpus all \
#     --env="NVIDIA_DRIVER_CAPABILITIES=all" \
#     --env="DISPLAY" \
#     --env="QT_X11_NO_MITSHM=1" \
#     --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
#     --volume="${DIR}/..":"/${WORKSPACE_NAME}":rw \
#     "${IMAGE_NAME}" \
#     bash -c "cd /${WORKSPACE_NAME} && colcon build"