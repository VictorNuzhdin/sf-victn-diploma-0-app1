#!/bin/bash

PROJECT_DIR=${PWD##*/}
#IMAGE0_FULL_NAME="dotspace2019/nve-diploma-webapp:2024.0505.174705"
#IMAGE1_FULL_NAME="webapp:latest"
IMAGE1_FULL_NAME="dotspace2019/nve-diploma-webapp:latest"
IMAGE2_FULL_NAME="dotspace2019/nve-diploma-pgadmin4:latest"
IMAGE3_FULL_NAME="dotspace2019/nve-diploma-postgres162:latest"
#
#
#

#--
clear

echo "--Removing Docker Images and Clear Build Cache.."
echo
echo "..Removing Images.."
echo
#docker rmi ${IMAGE0_FULL_NAME}
docker rmi ${IMAGE1_FULL_NAME}
docker rmi ${IMAGE2_FULL_NAME}
docker rmi ${IMAGE3_FULL_NAME}
echo
echo

echo "..Clearing Docker Build Cache.."
##      https://docs.docker.com/reference/cli/docker/builder/prune/
echo
docker builder prune --all --force
echo
echo

#echo "..Clearing Docker System.."
echo
docker system prune --all --force
echo
echo

#..cheks docker build/run results
./project_docker00Show.sh
