#!/bin/bash

DOCKER_REPO="dotspace2019"
APP_NAME="nve-diploma-webapp"
APP_VERSION="2024.0505.220527"
#
APP_TAG_0="${APP_VERSION}"
APP_TAG_1="latest"
APP_TAG_2="dev"


#--
clear

echo "--Sendings Current App Images to Docker Container Registry (Docker Hub).."
echo
#docker push ${DOCKER_REPO}/${APP_NAME}:${APP_TAG_0}"
#docker push ${DOCKER_REPO}/${APP_NAME}:${APP_TAG_1}"
docker push ${DOCKER_REPO}/${APP_NAME}:${APP_TAG_2}"

echo
echo
