#!/usr/bin/env bash
DIR=$(dirname "$(readlink -f "$0")")

DOCKER_BUILDKIT=1 docker build -f docker/base.dockerfile --progress=plain -t "base:latest" "${DIR}"/..