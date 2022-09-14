# syntax=docker.io/docker/dockerfile:1.3.1
# Requires https://github.com/moby/buildkit/pull/2089/commits/aa467196bdd5a5d8dd4fe805d590906d81619cdb

ARG ROS_DISTRO
ARG WORKSPACE_NAME

FROM ros:$ROS_DISTRO

# Make ARGs available
# See https://stackoverflow.com/questions/44438637/arg-substitution-in-run-command-not-working-for-dockerfile
ARG WORKSPACE_NAME
ARG ROS_DISTRO

WORKDIR /${WORKSPACE_NAME}

# Fix upgrade issues due to tzdata
ENV TZ=Etc/UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Update .bashrc
# This must be w.r.t. where build.bash.sh is called, i.e. in the project root
COPY ["bin/config.sh", "/"]
COPY ["bin/extra_bashrc.sh", "/"]
RUN echo "source /extra_bashrc.sh" > /etc/bash.bashrc

# Install basic tools
RUN \
    --mount=type=cache,target=/var/cache/apt \
    --mount=type=cache,target=/var/lib/apt \
    apt update \
    && apt upgrade -y \
    && apt install -y zsh vim gdb gdbserver python3-pip wget ccache lld xterm
# zsh, vim, gdb, python3-pip for development
# wget for installing drake
# ccache, lld for faster builds
# xterm for moveit demos

# Use custom rosdistro fork
RUN \
    wget https://raw.githubusercontent.com/rcywongaa/rosdistro/master/rosdep/sources.list.d/20-default.list -P /etc/ros/rosdep/sources.list.d/
ENV ROSDISTRO_INDEX_URL="https://raw.githubusercontent.com/rcywongaa/rosdistro/master/index-v4.yaml"

# Install non-ROS dependencies first
RUN \
    --mount=type=cache,target=/var/cache/apt \
    --mount=type=cache,target=/var/lib/apt \
    wget https://drake-packages.csail.mit.edu/drake/nightly/drake-dev_latest-1_amd64-jammy.deb \
    && apt update \
    && apt install -y ./drake-dev_latest-1_amd64-jammy.deb

# Install ROS dependencies
# Remember to mount else rosdep won't find any dependencies!
RUN \
    --mount=type=bind,target=/${WORKSPACE_NAME} \
    --mount=type=cache,target=/var/cache/apt \
    --mount=type=cache,target=/var/lib/apt \
    apt update \
    && rosdep update \
    && rosdep install -y --ignore-src --rosdistro ${ROS_DISTRO} --from-paths .

