#!/usr/bin/env bash
DIR=$(dirname "$(readlink -f "$0")")

source "${DIR}"/config.sh

DOCKER_BUILDKIT=1 docker build \
    -f docker/base.dockerfile \
    --progress=plain \
    --build-arg ROS_DISTRO="${ROS_DISTRO}" \
    --build-arg WORKSPACE_NAME="${WORKSPACE_NAME}" \
    -t "${IMAGE_NAME}" \
    "${DIR}"/..