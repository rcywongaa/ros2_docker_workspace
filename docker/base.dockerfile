# syntax=docker.io/docker/dockerfile:1.3.1
# Requires https://github.com/moby/buildkit/pull/2089/commits/aa467196bdd5a5d8dd4fe805d590906d81619cdb

ARG ROS_DISTRO
ARG WORKSPACE_NAME

FROM ros:$ROS_DISTRO

# Make ARGs available
# See https://stackoverflow.com/questions/44438637/arg-substitution-in-run-command-not-working-for-dockerfile
ARG WORKSPACE_NAME
ARG ROS_DISTRO

# Fix upgrade issues due to tzdata
ENV TZ=Etc/UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN \
    --mount=type=bind,target=/${WORKSPACE_NAME} \
    --mount=type=cache,target=/var/cache/apt \
    --mount=type=cache,target=/var/lib/apt \
    apt update \
    && apt upgrade -y \
    && apt install -y python3.9-dev \
    && rosdep update \
    && rosdep install -iy --rosdistro ${ROS_DISTRO} --from-paths /${WORKSPACE_NAME}
# python3.9-dev manually installed until https://discourse.ros.org/t/preparing-for-rolling-sync-delayed-by-python-3-10-transition/24521/4 resolved
ENTRYPOINT ["/ros_entrypoint.sh"]