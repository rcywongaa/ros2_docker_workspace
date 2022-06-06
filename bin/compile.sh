#!/usr/bin/env bash
DIR=$(dirname "$(readlink -f "$0")")

source "${DIR}"/config.sh

# Remember to quote each arg, make sure quotes don't interfere with quoting in bash -c "..."
DEFAULT_CMAKE_ARGS='" -DCMAKE_EXPORT_COMPILE_COMMANDS=1" " -DCMAKE_BUILD_TYPE=Debug"'
BUILD_ARGS="--cmake-clean-cache --cmake-args $DEFAULT_CMAKE_ARGS"

MAKE_CORES=
if [ ! -z "$1" ]; then
  MAKE_CORES=$1
  BUILD_ARGS="--parallel-workers $1 $BUILD_ARGS"
fi

rocker \
    --volume="${DIR}/..":"/${WORKSPACE_NAME}":rw \
    --user \
    -- \
    "${IMAGE_NAME}" \
    "bash -c 'cd /${WORKSPACE_NAME} && MAKEFLAGS=-j$MAKE_CORES colcon build $BUILD_ARGS'"
# See https://answers.ros.org/question/368249/colcon-build-number-of-threads/

# docker run -it --net=host --gpus all \
#     --env="NVIDIA_DRIVER_CAPABILITIES=all" \
#     --env="DISPLAY" \
#     --env="QT_X11_NO_MITSHM=1" \
#     --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
#     --volume="${DIR}/..":"/${WORKSPACE_NAME}":rw \
#     "${IMAGE_NAME}" \
#     bash -c "cd /${WORKSPACE_NAME} && colcon build"

