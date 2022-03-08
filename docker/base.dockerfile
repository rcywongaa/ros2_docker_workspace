# syntax=docker.io/docker/dockerfile:1.3.1
# Requires https://github.com/moby/buildkit/pull/2089/commits/aa467196bdd5a5d8dd4fe805d590906d81619cdb

ARG ROS_DISTRO
ARG WORKSPACE_NAME

FROM ros:$ROS_DISTRO

ARG WORKSPACE_NAME
RUN --mount=type=bind,target=/${WORKSPACE_NAME} --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt apt update && rosdep update && rosdep install -iy --from-paths /${WORKSPACE_NAME}
ENTRYPOINT ["/ros_entrypoint.sh"]