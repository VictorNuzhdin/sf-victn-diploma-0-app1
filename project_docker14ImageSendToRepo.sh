#!/bin/bash

DOCKER_REPO="dotspace2019"
APP_NAME="nve-diploma-webapp"
APP_VERSION="2024.0505.220527"
#
APP_TAG_0="${APP_VERSION}"
APP_TAG_1="latest"
IMAGE0_FULL_NAME="$DOCKER_REPO/$APP_NAME:$APP_TAG_0"
IMAGE1_FULL_NAME="$DOCKER_REPO/$APP_NAME:$APP_TAG_1"

#--
clear

echo "--Sendings Current App Images to Docker Container Registry (Docker Hub).."
echo
#docker push ${IMAGE0_FULL_NAME}
docker push ${IMAGE1_FULL_NAME}
echo
echo
