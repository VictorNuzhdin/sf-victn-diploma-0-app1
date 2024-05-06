#!/bin/bash

PROJECT_DIR=${PWD##*/}
APP_VERSION="2024.0505.220527"
#
IMAGE0_FULL_NAME="dotspace2019/nve-diploma-webapp:${APP_VERSION}"
IMAGE1_FULL_NAME="dotspace2019/nve-diploma-webapp:latest"
#
#
#

#--
clear

echo "--Removing Docker Images and Clear Build Cache.."
echo
echo "..Removing Images.."
echo
docker rmi ${IMAGE0_FULL_NAME}
docker rmi ${IMAGE1_FULL_NAME}
#
#
echo
echo

#echo "..Clearing Docker Build Cache.."
##      https://docs.docker.com/reference/cli/docker/builder/prune/
#echo
#docker builder prune --all --force
#echo
#echo

#echo "..Clearing Docker System.."
#echo
#docker system prune --all --force
#echo
#echo

#..cheks docker build/run results
./project_docker00Show.sh
