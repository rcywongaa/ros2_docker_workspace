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

# Update .bashrc
# This must be w.r.t. where build.bash.sh is called, i.e. in the project root
COPY ["bin/extra_bashrc.sh", "/"]
RUN echo "source /extra_bashrc.sh" > /etc/bash.bashrc

RUN \
    --mount=type=bind,target=/${WORKSPACE_NAME} \
    --mount=type=cache,target=/var/cache/apt \
    --mount=type=cache,target=/var/lib/apt \
    apt update \
    && apt upgrade -y \
    && rosdep update \
    && rosdep install -iy --rosdistro ${ROS_DISTRO} --from-paths /${WORKSPACE_NAME}
ENTRYPOINT ["/ros_entrypoint.sh"]